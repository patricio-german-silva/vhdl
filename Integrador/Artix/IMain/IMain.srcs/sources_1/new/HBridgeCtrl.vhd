----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 12:58:28 PM
-- Design Name: 
-- Module Name: HBridgeCtrl - Behavioral
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

entity HBridgeCtrl is
    Generic( POWER_SEL_WIDTH: NATURAL:=7;    -- Ancho en bits del selector de PWM
             PWM_DIV: NATURAL:=100;          -- Resolucion del PWM
             PWM_PERIOD: NATURAL:=10000);    -- Cantidad de pulsos de clock para cada unidad de PWM_DIV - Clock 100MHz, DIV 100 -> T=10000
    Port(piHBCClk : in STD_LOGIC;
         piHBCRst : in STD_LOGIC;
         piHBCEna : in STD_LOGIC;
         piHBCSet : in STD_LOGIC;
         piHBCDirSel : in STD_LOGIC;
         piHBCPowerSel: in STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
         poHBCDir : out STD_LOGIC_VECTOR(1 downto 0);
         poHBCPower : out STD_LOGIC;
         poHBCDirSel : out STD_LOGIC;                                            -- Señal de salida conectada al valor del latch
         poHBCPowerSel: out STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0)        -- Señal de salida conectada al valor del latch
         );
end HBridgeCtrl;

architecture A_HBridgeCtrl of HBridgeCtrl is
signal powerSel: STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
signal pwmClk, dirSel: STD_LOGIC;
begin

instModuleCounter: entity work.ModuleCounter(A_ModuleCounter)
    generic map(NBits => 20, Max => PWM_PERIOD) 
    port map(piMCClk => piHBCClk, piMCEna => piHBCEna, piMCRst => piHBCRst, poMCO => pwmClk);
    
instPwmGen: entity work.PwmGen(A_PwmGen)
    generic map(PWM_WIDTH => 7, ARR => PWM_DIV)
    port map(piPwmClk => pwmClk, piPwmEna => piHBCEna, piPwmRst => piHBCRst, piPwmPower => powerSel, poPwmPower => poHBCPower);


    P_SetPowerDir: process(piHBCClk, piHBCRst)
    begin
        if piHBCRst = '1' then
            powerSel <= std_logic_vector(to_unsigned(0, POWER_SEL_WIDTH));
        elsif rising_edge(piHBCClk) then
            if piHBCSet = '1' then
               powerSel <= piHBCPowerSel;
               dirSel <= piHBCDirSel;
            end if;
        end if;
    end process P_SetPowerDir;

    poHBCDirSel <= dirSel; 
    poHBCPowerSel <= powerSel;
    poHBCDir <= "00" when piHBCRst = '1' else
                "01" when dirSel = '1' else
                "10";
    
end A_HBridgeCtrl;
