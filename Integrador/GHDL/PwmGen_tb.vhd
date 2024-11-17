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
         poPower : out STD_LOGIC
         );
    end component;
    signal Clk, Ena, Rst, Power : std_logic;
    signal PowerSel: std_logic_vector(3 downto 0);

  
    begin
        instPwmGen: PwmGen
        generic map( PWM_WIDTH => 4, ARR => 16)
        port map(piPwmClk => Clk,
                piPwmEna => Ena,
                piPwmRst => Rst,
                piPwmPower => PowerSel,
                poPower => Power
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
     

        PowerSel <= "0111";
        wait for 200 ns;
      

        PowerSel <= "0001";
        wait for 200 ns;
      

        PowerSel <= "1100";
        wait for 200 ns;
      

        PowerSel <= "1110";
        wait for 200 ns;
      
        Rst <= '1';
        wait for 3 ns;
        Rst <= '0';
        wait;
     end process;
     
     
end Behavioral;

