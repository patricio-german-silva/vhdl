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
            piUaTxRdy : in STD_LOGIC;   -- Transmit ready - Los datos en piUaTxData estan listos para ser enviados
            poUaTxC : out STD_LOGIC;   -- Transmit Complete - Los datos en piUaTxData fueron enviados
            piUaTxData : in STD_LOGIC_VECTOR (8-1 downto 0)
    );
end UaTx;

architecture A_UaTx of UaTx is

Type TStates is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
signal state, next_state: TStates;
signal tx_ok, brgrst, brgclk: STD_LOGIC;
signal shiftReg: STD_LOGIC_VECTOR(8-1 downto 0);

begin

   instUaTxBRG: entity work.BaudRateGen(A_BaudRateGen)
      generic map( NBits => 14, Max => TxDIV, First => TxDIV)
      port map(piBRGClk => piUaTxClk, piBRGEna => '1', piBRGRst => brgrst, poBRGO => brgclk);

    SYNC_PROC : process (piUaTxClk)
    begin
        if rising_edge(piUaTxClk) then
            if (piUaTxRst = '1') then
                state <= S0;
                poUaTxC <= '0';
                brgrst <= '1';
                poUaTxTx <= '1';    -- Tx en alto -> idle
            else
                state <= next_state;
                brgrst <= '0';
                if (tx_ok = '1') then -- Datos listos para ser leidos desde en el buffer RX
                   poUaTxC <= '1';
                   tx_ok <= '0';
                end if;
            end if;
        end if; 
    end process;
    
    RX_NEXT_STATE_DECODE : process (state, brgclk, piUaTxEna)
    begin
        poUaTxTx <= '1';    -- Tx en alto -> idle
        case (state) is
            when S0 =>  -- Espera piUaTxRdy para copiar datos al shift register
               if piUaTxRdy = '1' then
                    poUaTxC <= '0';
                    shiftReg <= piUaTxData;
                    if piUaTxEna = '1' then
                        next_state <= S1;
                    else
                        next_state <= S0;
                    end if;
                end if;
            when S1 => -- envio de datos - bit start
                if brgclk = '1' then
                    poUaTxTx <= '0';
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;
            when S2 => -- envio de datos - bit 0
                if brgclk = '1' then
                    poUaTxTx <= shiftReg(0);
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;
            when S3 => -- envio de datos - bit 1
                if brgclk = '1' then
                    poUaTxTx <= shiftReg(1);
                    next_state <= S4;
                else
                    next_state <= S3;
                end if;
            when S4 => -- envio de datos - bit 2
                if brgclk = '1' then
                    poUaTxTx <= shiftReg(2);
                    next_state <= S5;
                else
                    next_state <= S4;
                end if;
            when S5 => -- envio de datos - bit 3
                if brgclk = '1' then
                    poUaTxTx <= shiftReg(3);
                    next_state <= S6;
                else
                    next_state <= S5;
                end if;
            when S6 => -- envio de datos - bit 4
                if brgclk = '1' then
                    poUaTxTx <= shiftReg(4);
                    next_state <= S7;
                else
                    next_state <= S6;
                end if;
            when S7 => -- envio de datos - bit 5
                if brgclk = '1' then
                    poUaTxTx <= shiftReg(5);
                    next_state <= S8;
                else
                    next_state <= S7;
                end if;
            when S8 => -- envio de datos - bit 6
                if brgclk = '1' then
                    poUaTxTx <= shiftReg(6);
                    next_state <= S9;
                else
                    next_state <= S8;
                end if;
            when S9 => -- envio de datos - bit 7
                if brgclk = '1' then
                    poUaTxTx <= shiftReg(7);
                    next_state <= S10;
                else
                    next_state <= S9;
                end if;
            when S10 => -- envio del bit de stop
               if (brgclk = '1') then
                    poUaTxTx <= '1';
                    tx_ok <= '1';
                    next_state <= S0;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process; 


end A_UaTx;
