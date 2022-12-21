----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2022 01:13:06 PM
-- Design Name: 
-- Module Name: Rx_test - Behavioral
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


-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 20.12.2022 11:31:22 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_Rx_top is
end tb_Rx_top;

architecture tb of tb_Rx_top is

    component Rx_top
        port (clk       : in std_logic;
              reset     : in std_logic;
              data_in   : in std_logic;
              led_ready : out std_logic;
              data      : out std_logic_vector (7 downto 0));
    end component;

    signal clk       : std_logic;
    signal reset     : std_logic;
    signal data_in   : std_logic;
    signal led_ready : std_logic;
    signal data      : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 100000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Rx_top
    port map (clk       => clk,
              reset     => reset,
              data_in   => data_in,
              led_ready => led_ready,
              data      => data);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        data_in <= '1';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '0';
        wait for 5000 ns;
        reset <= '1';
        wait for 100 us;
 		data_in <= '0';
        wait for 1000000000 ps;
        data_in <= '1';
        wait for 1000000000 ps;
        data_in <= '0';
        wait for 1000000000 ps;
        data_in <= '1';
        wait for 1000 us;
 		data_in <= '0';
        wait for 1000000000 ps;
        data_in <= '1';
        wait for 1000000000 ps;
        data_in <= '0';
        wait for 1000000000 ps;
        data_in <= '1';
        -- EDIT Add stimuli here
        
        wait for 10000 us;
 		data_in <= '0';
        wait for 1000000000 ps;
        data_in <= '1';
        wait for 1000000000 ps;
        data_in <= '0';
        wait for 1000000000 ps;
        data_in <= '1';
        wait for 1000000000 ps;
        data_in <= '0';
        wait for 1000000000 ps;
        data_in <= '1';
        
        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        
        wait for 10000 us;
 		data_in <= '0';
        wait for 1000000000 ps;
        data_in <= '1';
        wait for 1000000000 ps;
        data_in <= '0';
        wait for 1000000000 ps;
        data_in <= '1';
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

