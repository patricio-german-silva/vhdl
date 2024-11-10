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
--use IEEE.NUMERIC_STD.ALL;

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
signal motor1Sel, motor2Sel, motor1Dir, motor2Dir: STD_LOGIC;
begin
    
instMyPWM1: entity work.MyPWM(A_MyPWM)
    generic map(PWM_WIDTH => 2, ARR => 4, DIV_WIDTH => 20, DIV => 5)
    port map(piPwmClk => piClk, piPwmEna => '1', piPwmRst => piRst, piPwmPowerSelEna => motor1Sel, piPwmPowerSel => piPowerSel, poPower => poPowerM1);

instMyPWM2: entity work.MyPWM(A_MyPWM)
    generic map(PWM_WIDTH => 2, ARR => 4, DIV_WIDTH => 20, DIV => 5)
    port map(piPwmClk => piClk, piPwmEna => '1', piPwmRst => piRst, piPwmPowerSelEna => motor2Sel, piPwmPowerSel => piPowerSel, poPower => poPowerM2);


    P_SetPowerDir: process(piClk, piRst, piSet, piMotorSel, piDirSel)
    begin
        if rising_edge(piClk) then
            if piSet = '1' then
                motor1Sel <= piMotorSel;
                motor2Sel <= not piMotorSel;
                if piMotorSel = '1' then
                    motor1Dir <= piDirSel;
                else
                    motor2Dir <= piDirSel;
                end if;
            else
                motor1Sel <= '0';
                motor2Sel <= '0';
            end if;
        end if;
    end process P_SetPowerDir;

    poDirM1 <= "00" when piRst = '1' else
               "10" when motor1Dir = '1' else "01";
    poDirM2 <= "00" when piRst = '1' else
               "10" when motor2Dir = '1' else "01";
    
end A_MyMotorControl;
