----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 12:58:28 PM
-- Design Name: 
-- Module Name: MyMotorControl - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MyMotorControl is
    Generic( N: NATURAL:=2);
    Port(piClk : in STD_LOGIC;
         piRst : in STD_LOGIC;
         piSet : in STD_LOGIC;
         piMotorSel: in STD_LOGIC;
         piDirSel : in STD_LOGIC;
         piPowerSel: in STD_LOGIC_VECTOR (N-1 downto 0);
         poDirM1 : out STD_LOGIC_VECTOR(1 downto 0);
         poDirM2 : out STD_LOGIC_VECTOR(1 downto 0);
         poPowerM1 : out STD_LOGIC;
         poPowerM2 : out STD_LOGIC
         );
end MyMotorControl;

architecture A_MyMotorControl of MyMotorControl is
signal clkPwm: STD_LOGIC;
signal powerSelM1, powerSelM2, dirSelM1, dirSelM2: STD_LOGIC_VECTOR (N-1 downto 0);
begin

instMyModuleCounter: entity work.MyModuleCounter(A_MyModuleCounter)
    generic map(NBits => 20, Max => 500000) -- 200Hz = 500000 . En 5 para testeo
    port map(piMCClk => piClk, piMCEna => '1', piMCRst => piRst, poX => clkPwm);
    
instMyPWM1: entity work.MyPWM(A_MyPWM)
    generic map(PWM_WIDTH => 2, ARR => 4)
    port map(piPwmClk => clkPwm, piPwmEna => '1', piPwmRst => piRst, piPwmPower => powerSelM1, poPower => poPowerM1);

instMyPWM2: entity work.MyPWM(A_MyPWM)
    generic map(PWM_WIDTH => 2, ARR => 4)
    port map(piPwmClk => clkPwm, piPwmEna => '1', piPwmRst => piRst, piPwmPower => powerSelM2, poPower => poPowerM2);


    P_SetPowerDir: process(piClk, piRst, piSet, piMotorSel, piDirSel)
    begin
        if piRst = '1' then
            powerSelM1 <= std_logic_vector(to_unsigned(0, N));
            dirSelM1 <= "00";
            powerSelM2 <=  std_logic_vector(to_unsigned(0, N));
            dirSelM2 <= "00";
        elsif rising_edge(piClk) then
            if piSet = '1' then
                if piMotorSel = '1' then
				   powerSelM1 <= piPowerSel;
                   if piDirSel = '1' then
                       dirSelM1 <= "01";
                   else
                       dirSelM1 <= "10";
                   end if;
                else
				   powerSelM2 <= piPowerSel;
                   if piDirSel = '1' then
                       dirSelM2 <= "01";
                   else
                       dirSelM2 <= "10";
                   end if;
                end if;
            end if;
        end if;
    end process P_SetPowerDir;

    poDirM1 <= dirSelM1;
    poDirM2 <= dirSelM2;
    
end A_MyMotorControl;
