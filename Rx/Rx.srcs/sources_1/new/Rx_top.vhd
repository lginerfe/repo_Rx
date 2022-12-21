----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2022 01:07:50 PM
-- Design Name: 
-- Module Name: Rx_top - Behavioral
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

entity Rx_top is
  port ( 
    clk: in std_logic;
    reset: in std_logic;
    data_in: in std_logic;
    led_ready: out std_logic;
    data: out std_logic_vector(7 downto 0));
end Rx_top;

architecture Behavioral of Rx_top is

component Rx
port ( clk: in std_logic;
    reset: in std_logic;
    start: in std_logic;
    data_in: in std_logic;
    led_ready: out std_logic;
    data: out std_logic_vector(7 downto 0));
end component;

component boton_start
port(	clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        start_button: out std_logic );
end component;
 
signal inicio_recepcion : std_logic;

begin

dut1: boton_start
port map (clk => clk,
        reset => reset,
        start => data_in,
        start_button => inicio_recepcion);
   
dut2: Rx
port map( clk=> clk,
    reset => reset,
    start => inicio_recepcion,
    data_in => data_in,
    led_ready => led_ready,
    data => data);
    
end Behavioral;
