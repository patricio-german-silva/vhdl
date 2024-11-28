----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:03:04 PM
-- Design Name: 
-- Module Name: UaTx - Behavioral
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

entity UaTx is
    Generic ( TxDIV: NATURAL:= 10417); -- 100Mhz/DIV -> 9600 baud
    Port (  piUaTxClk : in STD_LOGIC; -- Clock de entrada
            piUaTxRst : in STD_LOGIC; -- Reset
            piUaTxEna : in STD_LOGIC; -- TX Enable

            poUaTxTx : out STD_LOGIC;    -- Puerto TX
            piUaTxDataRdy : in STD_LOGIC;   -- Transmit ready - Los datos en piUaTxData estan listos para ser enviados
            poUaTxC : out STD_LOGIC;   -- Transmit Complete - Los datos en piUaTxData fueron enviados
            piUaTxData : in STD_LOGIC_VECTOR (8-1 downto 0)
    );
end UaTx;

architecture A_UaTx of UaTx is

Type TStates is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11);
signal state, next_state: TStates;
signal brgrst: STD_LOGIC;
signal brgclk: STD_LOGIC;
signal latch: STD_LOGIC_VECTOR(8-1 downto 0);

begin

   instUaTxBRG: entity work.BaudRateGen(A_BaudRateGen)
      generic map( NBits => 14, Max => TxDIV, First => TxDIV)
      port map(piBRGClk => piUaTxClk, piBRGEna => '1', piBRGRst => brgrst, poBRGO => brgclk);

    SYNC_PROC : process (piUaTxClk)
    begin
        if rising_edge(piUaTxClk) then
            if (piUaTxRst = '1') then
                state <= S0;
            else
                state <= next_state;
            end if;
        end if; 
    end process;
    
    
    OUTPUT_DECODE : process (state)
    begin
    brgrst <= '0';
    case (state) is
        when S0 =>
            brgrst <= '1';
            poUaTxC <= '0';
        when S1 =>
            latch <= piUaTxData;
        when S11 =>
            poUaTxC <= '1';
        when others =>
            poUaTxC <= '0';
    end case;
    end process OUTPUT_DECODE;


    RX_NEXT_STATE_DECODE : process (state, brgclk, piUaTxEna, piUaTxDataRdy)
    begin
        case (state) is
            when S0 =>  -- Espera piUaTxDataRdy para copiar datos al shift register y comenzar
                poUaTxTx <= '1';
                if (piUaTxDataRdy) = '1' and (piUaTxEna = '1') then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 => -- envio de datos - bit start
                poUaTxTx <= '0';
                if brgclk = '1' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;
            when S2 => -- envio de datos - bit 0
                poUaTxTx <= latch(0);
                if brgclk = '1' then
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;
            when S3 => -- envio de datos - bit 1
                poUaTxTx <= latch(1);
                if brgclk = '1' then
                    next_state <= S4;
                else
                    next_state <= S3;
                end if;
            when S4 => -- envio de datos - bit 2
                poUaTxTx <= latch(2);
                if brgclk = '1' then
                    next_state <= S5;
                else
                    next_state <= S4;
                end if;
            when S5 => -- envio de datos - bit 3
                poUaTxTx <= latch(3);
                if brgclk = '1' then
                    next_state <= S6;
                else
                    next_state <= S5;
                end if;
            when S6 => -- envio de datos - bit 4
                poUaTxTx <= latch(4);
                if brgclk = '1' then
                    next_state <= S7;
                else
                    next_state <= S6;
                end if;
            when S7 => -- envio de datos - bit 5
                poUaTxTx <= latch(5);
                if brgclk = '1' then
                    next_state <= S8;
                else
                    next_state <= S7;
                end if;
            when S8 => -- envio de datos - bit 6
                poUaTxTx <= latch(6);
                if brgclk = '1' then
                    next_state <= S9;
                else
                    next_state <= S8;
                end if;
            when S9 => -- envio de datos - bit 7
                poUaTxTx <= latch(7);
                if brgclk = '1' then
                    next_state <= S10;
                else
                    next_state <= S9;
                end if;
            when S10 => -- envio del bit de stop
               poUaTxTx <= '1';
               if (brgclk = '1') then
                    next_state <= S11;
               else
                   next_state <= S10;
               end if;
            when S11 => -- Se finalizó la transmisión, poUaTxC durante 1 clock de sistema
               poUaTxTx <= '1';
               next_state <= S0;
            when others =>
                next_state <= S0;
        end case;
    end process; 


end A_UaTx;
