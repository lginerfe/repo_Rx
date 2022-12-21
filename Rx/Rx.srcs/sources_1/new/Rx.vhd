----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2022 01:11:48 PM
-- Design Name: 
-- Module Name: Rx - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rx is
  port ( 
    clk: in std_logic;
    reset: in std_logic;
    start: in std_logic;
    data_in: in std_logic;
    led_ready: out std_logic;
    data: out std_logic_vector(7 downto 0));
end Rx;

architecture Behavioral of Rx is

constant baud_rate  : integer := 9600;
constant clk_rate   : integer := 100000;

constant widthhalf_count_max 	: integer := clk_rate/(baud_rate*2);
constant width_count_max 	: integer := clk_rate/(baud_rate);
constant bit_count_max		: integer := 10;

signal width_count 		: integer range 0 to width_count_max := 0;
signal widthhalf_count 		: integer range 0 to widthhalf_count_max := 0;
signal bit_count		: integer range 0 to bit_count_max := 0;

signal ready		: std_logic := '1';
signal done			: std_logic := '0';
signal width_max	: std_logic := '1';
signal widthhalf_max : std_logic := '0';
signal bit_max		: std_logic := '0';
signal data_in_reg	: std_logic;
signal reg_data 	: std_logic_vector (9 downto 0) := (others => 'X');

type tipo_estado is (init, load_start, load, fin);
signal next_state, pres_state : tipo_estado;

signal prueba,inicio_cuenta: std_logic := '0';

begin
data_in_reg <= data_in;
data <= reg_data(8 downto 1);
led_ready <= ready;

-- actualizar estado
actualiza: process(clk, reset)
begin
	if (reset ='0') then
		pres_state <= init;
	elsif rising_edge(clk) then
    	pres_state <= next_state;
    end if;
end process actualiza;

-- trnasiciones
transition: process(pres_state, bit_count, widthhalf_max, width_max, done, start)
begin
	case pres_state is
	when init => 
    	if rising_edge(start) then
        	next_state <= load_start;
        else
        	next_state <= init;
        end if;
    when load_start =>
		if widthhalf_max = '1' then
        	next_state <= load;   prueba <= '1';
        else
        	next_state <= load_start; prueba <= '0';
        end if;
    when load => 
    	if bit_count = 9  then
        	next_state <= fin;
        else
        	next_state <= load;
        end if;
    when fin =>
    	if done = '1' then 
        	next_state <= init;
        else
        	next_state <= fin;
        end if;
    when others => next_state <= init;
    end case;
end process transition;

--actuadores
actions: process (pres_state, start, width_count, bit_max, widthhalf_count)
begin
	case pres_state is
	when init => 
        if rising_edge(start) then
        	ready <= '0';
            inicio_cuenta <= '0';
        end if;
    when load_start =>
		done <= '0';
        if widthhalf_count = widthhalf_count_max-1 then
        	inicio_cuenta <= '1';
            bit_count <= 0;
            reg_data <= data_in_reg & reg_data(9 downto 1);
        end if;
    when load => 
        if (width_count = width_count_max-1) then
        	bit_count <= bit_count+1;
        	reg_data <= data_in_reg & reg_data(9 downto 1);
        end if;
    when fin =>
    	if data_in = '1' then
        	done <= '1'; 
            ready <= '1';
            bit_count <= 0;
        else
        	done <= '0';
        end if;
    when others => 
    end case;
end process actions;
-- contador mitad ancho
mitadancho: process (clk, reset, ready, inicio_cuenta, widthhalf_count)
begin 
    if reset ='0'  or (ready = '1') then
        widthhalf_count <= 0;
        widthhalf_max <= '0';
    elsif rising_edge (clk) then
        if (widthhalf_count = widthhalf_count_max-1) then
            widthhalf_count <= 0;
            widthhalf_max <='1';
        else
            widthhalf_count <= widthhalf_count + 1;
            widthhalf_max <= '0';
         end if;
    end if;   
end process mitadancho;
--contador ancho lectura
ancho: process (clk, reset, ready, width_count)
begin 
    if reset ='0'  or (ready = '1') or (inicio_cuenta ='0') then
        width_count <= 0;
        width_max <= '0';
    elsif rising_edge (clk) then
        if (width_count = width_count_max-1) then
            width_max <= '1';
            width_count <= 0;
        else
            width_count <= width_count + 1;
            width_max <= '0';
         end if;
    end if;   
end process ancho;

end Behavioral;
