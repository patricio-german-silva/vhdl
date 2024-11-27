----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:03:04 PM
-- Design Name: 
-- Module Name: DecodeCmd - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Interpreta comandos de entrada y ejecuta
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

entity DecodeCmd is
    Generic( POWER_SEL_WIDTH: NATURAL:=7);    -- Ancho en bits del selector de PWM
    Port (  piDCMDClk : in STD_LOGIC;
            piDCMDRst : in STD_LOGIC;
            piDCMDEna : in STD_LOGIC;
            piDCMDCmdRdy: in STD_LOGIC; -- Recibido nuevo comando
            piDCMDCmd : in STD_LOGIC_VECTOR(7 downto 0);
            piDCMDData : in STD_LOGIC_VECTOR (15 downto 0);
            piDCMDSensors: in STD_LOGIC_VECTOR(3 downto 0);
            poDCMDSetMD : out STD_LOGIC;
            poDCMDDirSelMD : out STD_LOGIC;
            poDCMDPowerSelMD: out STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
            poDCMDSetMI : out STD_LOGIC;
            poDCMDDirSelMI : out STD_LOGIC;
            poDCMDPowerSelMI: out STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
            poDCMDMode: out STD_LOGIC
    );
end DecodeCmd;

architecture A_DecodeCmd of DecodeCmd is

    constant CMD_STOP: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8));
    constant CMD_VEL_MOTOR_DER: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(1, 8));
    constant CMD_VEL_MOTOR_IZQ: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(2, 8));
    constant CMD_VEL_MEDIA: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(3, 8));
    constant CMD_SIM_SENSOR: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(4, 8));
    constant CMD_MODE: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(5, 8));
    constant CMD_MODE_CONTROL_PC: STD_LOGIC := '0';
    constant CMD_MODE_CONTROL_SENSORS: STD_LOGIC := '1';

    signal power, avg_power: UNSIGNED(7 downto 0);
    signal sensors: STD_LOGIC_VECTOR(3 downto 0);
    signal clk10ms: STD_LOGIC;
    signal auto, mode: STD_LOGIC := '0';

begin

    -- Tiempo de actualizacion de las velocidades segun los sensores
    instModuleCounter: entity work.ModuleCounter(A_ModuleCounter)
        generic map(NBits => 20, Max => 1000000) 
        port map( piMCClk => piDCMDClk, piMCEna => auto, piMCRst => piDCMDRst, poMCO => clk10ms);	



    PROCESS_CMD: process(piDCMDClk, piDCMDCmdRdy)
    begin
        poDCMDSetMD <= '0';
        poDCMDSetMI <= '0';
        if rising_edge(piDCMDClk) then
            if piDCMDCmdRdy = '1' then          -----    COMANDOS A EJECUTAR
                if piDCMDData(3 downto 0) = "0000" then
                    power <= UNSIGNED(piDCMDData(11 downto 8)) * 10;
                else
                    power <= UNSIGNED(piDCMDData(11 downto 8)) * 10 + 5;
                end if;

                if piDCMDCmd = CMD_STOP then
                    auto <= '0';
                    poDCMDSetMD <= '1';
                    poDCMDPowerSelMD <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, POWER_SEL_WIDTH));
                    poDCMDSetMI <= '1';
                    poDCMDPowerSelMI <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, POWER_SEL_WIDTH));
                elsif piDCMDCmd = CMD_VEL_MOTOR_DER then
                    auto <= '0';
                    poDCMDSetMD <= '1';
                    poDCMDDirSelMD <= '1';
                    poDCMDPowerSelMD <= STD_LOGIC_VECTOR(power(6 downto 0));
                elsif piDCMDCmd = CMD_VEL_MOTOR_IZQ then
                    auto <= '0';
                    poDCMDSetMI <= '1';
                    poDCMDDirSelMI <= '1';
                    poDCMDPowerSelMI <= STD_LOGIC_VECTOR(power(6 downto 0));
                elsif piDCMDCmd = CMD_VEL_MEDIA then
                    auto <= '1';
                    avg_power <= power;
                    poDCMDSetMD <= '1';
                    poDCMDDirSelMD <= '1';
                    poDCMDPowerSelMD <= STD_LOGIC_VECTOR(power(6 downto 0));
                    poDCMDSetMI <= '1';
                    poDCMDDirSelMI <= '1';
                    poDCMDPowerSelMI <= STD_LOGIC_VECTOR(power(6 downto 0));
                elsif  piDCMDCmd = CMD_SIM_SENSOR and mode = CMD_MODE_CONTROL_PC then
                    sensors <= piDCMDData(11 downto 8);
                elsif piDCMDCmd = CMD_MODE then
                    mode <= piDCMDData(8);
                end if;
            else
                if mode = CMD_MODE_CONTROL_SENSORS then
                    sensors <= piDCMDSensors;
                end if;
            end if;
        end if;
        if rising_edge(clk10ms) then
            if sensors = "1100" then
                poDCMDSetMI <= '1';
                poDCMDDirSelMI <= '1';
                poDCMDPowerSelMI <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 7));
            elsif sensors = "0011" then
                poDCMDSetMD <= '1';
                poDCMDDirSelMD <= '1';
                poDCMDPowerSelMD <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 7));
            else
                poDCMDSetMD <= '1';
                poDCMDDirSelMD <= '1';
                poDCMDPowerSelMD <= STD_LOGIC_VECTOR(avg_power(6 downto 0));
                poDCMDSetMI <= '1';
                poDCMDDirSelMI <= '1';
                poDCMDPowerSelMI <= STD_LOGIC_VECTOR(avg_power(6 downto 0));
            end if;
        end if;
    end process;

    poDCMDMode <= mode;

end A_DecodeCmd;
