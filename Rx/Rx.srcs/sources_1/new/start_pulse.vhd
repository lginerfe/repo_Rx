----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2022 01:09:07 PM
-- Design Name: 
-- Module Name: start_pulse - Behavioral
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

entity boton_start is
  port (clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        start_button: out std_logic);
end boton_start;

architecture Behavioral of boton_start is
signal start_reg: std_logic_vector(1 downto 0) := (others => '0');

begin
--registro  start
start_button <= start_reg(0) and start_reg(1);
p_start: process (clk, reset)
begin
if reset ='0' then				--reset
    start_reg <= (others => '0');
elsif rising_edge(clk) then		--flacno de reloj
    start_reg(0) <= not start;
    start_reg(1) <= not start_reg(0);
end if;
end process p_start;

end Behavioral;


