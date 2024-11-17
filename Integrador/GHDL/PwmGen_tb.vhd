----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 05:41:18 PM
-- Design Name: 
-- Module Name: PwmGen_tb - Behavioral
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

entity PwmGen_tb is
--  Port ( );
end PwmGen_tb;

architecture Behavioral of PwmGen_tb is

    component PwmGen is
    Generic(PWM_WIDTH: NATURAL:=12;
            ARR: NATURAL := 4096
            );
    Port(piPwmClk : in STD_LOGIC;
         piPwmEna : in STD_LOGIC;
         piPwmRst : in STD_LOGIC;
         piPwmPower: in STD_LOGIC_VECTOR(PWM_WIDTH-1 downto 0);
         poPwmPower : out STD_LOGIC
         );
    end component;
    signal Clk, Ena, Rst, Power : std_logic;
    signal PowerSel: std_logic_vector(7-1 downto 0);

  
    begin
        instPwmGen: PwmGen
        generic map( PWM_WIDTH => 7, ARR => 10)
        port map(piPwmClk => Clk,
                piPwmEna => Ena,
                piPwmRst => Rst,
                piPwmPower => PowerSel,
                poPwmPower => Power
         );

        pClk: process
        begin
            Clk <= '1';
            wait for 1 ns;
            Clk <= '0';
            wait for 1 ns;
        end process;
      
    process
    begin
        Rst <= '1';
        Ena <= '0';
        wait for 3 ns;--
      
        Rst <= '0';
        ena <= '1';
        wait for 4 ns;
     

        PowerSel <= "0000001";
        wait for 200 ns;
      

        PowerSel <= "0000010";
        wait for 200 ns;
      

        PowerSel <= "0000100";
        wait for 200 ns;
      

        PowerSel <= "0001000";
        wait for 200 ns;
      

        Rst <= '1';
        wait for 3 ns;
        Rst <= '0';
        wait;
     end process;
     
     
end Behavioral;

