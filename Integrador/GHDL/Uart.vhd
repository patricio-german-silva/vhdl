----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:03:04 PM
-- Design Name: 
-- Module Name: Uart - Behavioral
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
-- Solo recepcion, rs232, sin paridad, sin flow control, 8 bits
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

entity Uart is
    Generic ( DIV: NATURAL:= 10417); -- 100Mhz/DIV -> 9600 baud
    Port (  piUartClk : in STD_LOGIC; -- Clock de entrada
            piUartRst : in STD_LOGIC; -- Reset
    
            piUartRxEna : in STD_LOGIC; -- RX Enable
            piUartTxEna : in STD_LOGIC; -- TX Enable

            piUartRx : in STD_LOGIC;    -- Puerto RX
            piUartRxAck: in STD_LOGIC;   -- Receive complete acknowledge, se terninaron de leer datos en poUartRxData, se limpia el flag poUartRxC
            poUartRxC: out STD_LOGIC; -- Receive complete - Hay datos para leer en el buffer poUartRxData 
            poUartRxData : out STD_LOGIC_VECTOR (8-1 downto 0);

            poUartTx : in STD_LOGIC;    -- Puerto TX
            piUartTxRdy : in STD_LOGIC;   -- Transmit ready - Los datos en piUartTxData estan listos para ser enviados
            poUartTxC : in STD_LOGIC;   -- Transmit Complete - Los datos en piUartTxData fueron enviados
            piUartTxData : out STD_LOGIC_VECTOR (8-1 downto 0)
    );
end Uart;

architecture A_Uart of Uart is

Type TStates is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
signal state, next_state: TStates;
signal rx_ok, brgrst, brgclk: STD_LOGIC;
signal tmpRxData: STD_LOGIC_VECTOR(8-1 downto 0);

begin

    instBAUDRATEGEN: entity work.BaudRateGen(A_BaudRateGen)
        generic map( NBits => 14, Max => DIV)
        port map(piBRGClk => piUartClk, piBRGEna => '1', piBRGRst => brgrst, poBRGO => brgclk);

    SYNC_PROC : process (piUartClk)
    begin
        if rising_edge(piUartClk) then
            if (piUartRst = '1') then
                state <= S0;
                poUartRxC <= '0';
            else
                state <= next_state;
                brgrst <= '0';
                if (rx_ok = '1') and (piUartRxEna = '1') then -- Datos listos para ser leidos desde en el buffer RX
                   poUartRxData <= tmpRxData;
                   poUartRxC <= '1';
                   rx_ok <= '0';
                elsif piUartRxAck = '1' then
                   poUartRxC <= '0';
                end if;
            end if;
        end if; 
    end process;
    
    RX_NEXT_STATE_DECODE : process (state, brgclk, piUartRx, piUartRxEna)
    begin
        case (state) is
            when S0 =>  -- Espera bit start
               if piUartRx = '0' then
                    if piUartRxEna = '1' then
                        next_state <= S1;
                        brgrst <= '1';
                    else
                        next_state <= S0;
                    end if;
                end if;
            when S1 =>  -- Chequeo que es bit start tras medio periodo
                if (brgclk = '1') and (piUartRx = '0') then
                     next_state <= S2;
                 else
                     next_state <= S0;
                end if;
            when S2 => -- recepcion de datos - bit 0
                if brgclk = '1' then
                    tmpRxData(0) <= piUartRx;
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;
            when S3 => -- recepcion de datos - bit 1
                if brgclk = '1' then
                    tmpRxData(1) <= piUartRx;
                    next_state <= S4;
                else
                    next_state <= S3;
                end if;
            when S4 => -- recepcion de datos - bit 2
                if brgclk = '1' then
                    tmpRxData(2) <= piUartRx;
                    next_state <= S5;
                else
                    next_state <= S4;
                end if;
            when S5 => -- recepcion de datos - bit 3
                if brgclk = '1' then
                    tmpRxData(3) <= piUartRx;
                    next_state <= S6;
                else
                    next_state <= S5;
                end if;
            when S6 => -- recepcion de datos - bit 4
                if brgclk = '1' then
                    tmpRxData(4) <= piUartRx;
                    next_state <= S7;
                else
                    next_state <= S6;
                end if;
            when S7 => -- recepcion de datos - bit 5
                if brgclk = '1' then
                    tmpRxData(5) <= piUartRx;
                    next_state <= S8;
                else
                    next_state <= S7;
                end if;
            when S8 => -- recepcion de datos - bit 6
                if brgclk = '1' then
                    tmpRxData(6) <= piUartRx;
                    next_state <= S9;
                else
                    next_state <= S8;
                end if;
            when S9 => -- recepcion de datos - bit 7
                if brgclk = '1' then
                    tmpRxData(7) <= piUartRx;
                    next_state <= S10;
                else
                    next_state <= S9;
                end if;
            when S10 => -- recepcion del bit de stop
               if (brgclk = '1') then
                    if (piUartRx = '1') then
                       rx_ok <= '1';
                    end if;
                    next_state <= S0;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process; 


end A_Uart;
