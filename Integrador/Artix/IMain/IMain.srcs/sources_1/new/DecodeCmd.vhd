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
    Generic( POWER_SEL_WIDTH: NATURAL:=7;    -- Ancho en bits del selector de PWM
             CTRL_PERIOD: NATURAL:=1000000); -- Timepo de actualización de la velocidad
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

    constant CMD_STOP: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(48, 8));  -- 0x30 -> '0'
    constant CMD_VEL_MOTOR_DER: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(49, 8));
    constant CMD_VEL_MOTOR_IZQ: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(50, 8));
    constant CMD_VEL_MEDIA: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(51, 8));
    constant CMD_SIM_SENSOR: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(52, 8));
    constant CMD_MODE: STD_LOGIC_VECTOR(7 downto 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(53, 8));
    constant PC_CONTROL_MODE: STD_LOGIC := '0';
    constant SENSORS_CONTROL_MODE: STD_LOGIC := '1';

    signal power : STD_LOGIC_VECTOR(7 downto 0);
    signal avg_power, fpower, lpower: UNSIGNED(7 downto 0);
    signal sensors: STD_LOGIC_VECTOR(3 downto 0);
    signal clk10ms: STD_LOGIC;
    signal mode: STD_LOGIC := '1';  -- Modo 1: control por sensores
    signal auto, stop: STD_LOGIC := '0';
    
    -- LATCH
    signal r_CmdRdy : STD_LOGIC; -- Recibido nuevo comando
    signal r_Cmd : STD_LOGIC_VECTOR(7 downto 0);
    signal r_Data :  STD_LOGIC_VECTOR (15 downto 0);
begin

    -- Tiempo de actualizacion de las velocidades segun los sensores
    instModuleCounter: entity work.ModuleCounter(A_ModuleCounter)
        generic map(NBits => 20, Max => CTRL_PERIOD) 
        port map( piMCClk => piDCMDClk, piMCEna => '1', piMCRst => piDCMDRst, poMCO => clk10ms);	



    PROCESS_CMD: process(piDCMDClk, piDCMDCmdRdy, clk10ms)
    begin
        r_CmdRdy <= piDCMDCmdRdy;
        r_Cmd <= piDCMDCmd;
        r_Data <= piDCMDData;
        if rising_edge(piDCMDClk) then
            poDCMDSetMD <= '0';
            poDCMDSetMI <= '0';
            stop <= '0';
            if r_CmdRdy = '1' then          -----    COMANDOS A EJECUTAR
                if r_Cmd = CMD_STOP then
                    auto <= '0';
                    poDCMDSetMD <= '1';
                    poDCMDSetMI <= '1';
                    stop <= '1';
                elsif r_Cmd = CMD_VEL_MOTOR_DER then
                    auto <= '0';
                    poDCMDSetMD <= '1';
                elsif r_Cmd = CMD_VEL_MOTOR_IZQ then
                    auto <= '0';
                    poDCMDSetMI <= '1';
                elsif r_Cmd = CMD_VEL_MEDIA then
                    -- Activo mod Automatico, asigno potencia media y calculo velocidad baja y alta
                    auto <= '1';
                    avg_power <= UNSIGNED(power);
                    if UNSIGNED(power) < 80 then
                        fpower <= UNSIGNED(power) + TO_UNSIGNED(20, 8);
                    else
                        fpower <= TO_UNSIGNED(100, 8);
                    end if;
                    if UNSIGNED(power) > 20 then 
                        lpower <= UNSIGNED(power) - TO_UNSIGNED(20, 8);
                    else
                        lpower <= TO_UNSIGNED(0, 8);
                    end if;
                elsif (r_Cmd = CMD_SIM_SENSOR) and (mode = PC_CONTROL_MODE) then
                    sensors <= r_Data(11 downto 8);
                elsif r_Cmd = CMD_MODE then
                    mode <= r_Data(8);
                end if;
            else
                if mode = SENSORS_CONTROL_MODE then
                    sensors <= piDCMDSensors;
                end if;
            end if;
        end if;

        if auto = '1' then  --- Actualización en modo automatico
            if rising_edge(clk10ms) then
                if sensors = "1100" then
                    poDCMDSetMD <= '1';
                    poDCMDSetMI <= '1';
                    poDCMDPowerSelMD <= STD_LOGIC_VECTOR(fpower(6 downto 0));
                    poDCMDPowerSelMI <= STD_LOGIC_VECTOR(lpower(6 downto 0));
                elsif sensors = "0011" then
                    poDCMDSetMD <= '1';
                    poDCMDSetMI <= '1';
                    poDCMDPowerSelMD <= STD_LOGIC_VECTOR(lpower(6 downto 0));
                    poDCMDPowerSelMI <= STD_LOGIC_VECTOR(fpower(6 downto 0));
                elsif sensors = "1000" then
                    poDCMDSetMD <= '1';
                    poDCMDSetMI <= '1';
                    poDCMDPowerSelMD <= STD_LOGIC_VECTOR(TO_UNSIGNED(100, 7));
                    poDCMDPowerSelMI <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 7));
                elsif sensors = "0001" then
                    poDCMDSetMD <= '1';
                    poDCMDSetMI <= '1';
                    poDCMDPowerSelMD <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 7));
                    poDCMDPowerSelMI <= STD_LOGIC_VECTOR(TO_UNSIGNED(100, 7));
                else
                    poDCMDSetMD <= '1';
                    poDCMDSetMI <= '1';
                    poDCMDPowerSelMD <= STD_LOGIC_VECTOR(avg_power(6 downto 0));
                    poDCMDPowerSelMI <= STD_LOGIC_VECTOR(avg_power(6 downto 0));
                end if;
            end if;
        else
            poDCMDPowerSelMD <= STD_LOGIC_VECTOR(power(6 downto 0));
            poDCMDPowerSelMI <= STD_LOGIC_VECTOR(power(6 downto 0));
        end if;
    end process PROCESS_CMD;





    power <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)) when stop = '1' else
             STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)) when UNSIGNED(piDCMDData(11 downto 8)) = 0 else
             STD_LOGIC_VECTOR(TO_UNSIGNED(100, 8)) when (UNSIGNED(piDCMDData(11 downto 8)) = 9) and (UNSIGNED(piDCMDData(3 downto 0)) /= 0) else
             STD_LOGIC_VECTOR(UNSIGNED(piDCMDData(11 downto 8)) * 10) when UNSIGNED(piDCMDData(3 downto 0)) < 5 else
             STD_LOGIC_VECTOR(UNSIGNED(piDCMDData(11 downto 8)) * 10 + 5);

    -- Direccion siempre hacia adelante 
    poDCMDDirSelMD <= '1';
    poDCMDDirSelMI <= '1';

    poDCMDMode <= mode;

end A_DecodeCmd;
