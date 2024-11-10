----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 01:21:18 PM
-- Design Name: 
-- Module Name: MyPWM - Behavioral
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


entity MyPWM is
    Generic(PWM_WIDTH: NATURAL:=2;    -- Cantidad de bits del contador PWM
            ARR: NATURAL := 4;        -- Valor en que el contador vuwlve a 0
            DIV_WIDTH: NATURAL := 25;  -- Cantidad de bits para el contador divisor
            DIV: NATURAL := 25000000 -- Divisor interno, la salida pwm tiene periodo T=DIV*piPwmClk.
            );
    Port(piPwmClk : in STD_LOGIC;
         piPwmEna : in STD_LOGIC;
         piPwmRst : in STD_LOGIC;
         piPwmPowerSelEna : in STD_LOGIC;
         piPwmPowerSel: in STD_LOGIC_VECTOR(PWM_WIDTH-1 downto 0);
         poPower : out STD_LOGIC
         );
end MyPWM;

architecture A_MyPWM of MyPWM is

signal powerSet: unsigned(PWM_WIDTH-1 downto 0);
signal powerCount: unsigned(PWM_WIDTH-1 downto 0);
signal divCount: unsigned(DIV_WIDTH-1 downto 0);

begin
    
    pwmProcess: process(piPwmClk, piPwmEna, piPwmRst, piPwmPowerSelEna, piPwmPowerSel)
    begin
        if piPwmRst = '1' then
           powerCount <= to_unsigned(0, PWM_WIDTH);
           powerSet <= to_unsigned(0, PWM_WIDTH);
           divCount <= to_unsigned(0, DIV_WIDTH);
        elsif rising_edge(piPwmClk) then
            if piPwmPowerSelEna = '1' then
                powerSet <= UNSIGNED(piPwmPowerSel);
			elsif piPwmEna = '1' then
			    divCount <= divCount + to_unsigned(1, DIV_WIDTH);
			    if divCount = to_unsigned(DIV-1, DIV_WIDTH) then
			        divCount <= to_unsigned(0, DIV_WIDTH);
                    powerCount <= powerCount + to_unsigned(1, PWM_WIDTH);
                    if powerCount = to_unsigned(ARR-1, PWM_WIDTH) then
                        powerCount <= to_unsigned(0, PWM_WIDTH);
                    end if;
                end if;
			end if;	
        end if;      
    end process pwmProcess;

    poPower <= '0' when (piPwmRst = '1' or piPwmEna = '0') else
               '1' when powerCount < powerSet else '0';


end A_MyPWM;
