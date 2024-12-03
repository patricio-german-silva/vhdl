----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:03:04 PM
-- Design Name: 
-- Module Name: UaRx - Behavioral
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

entity UaRx is
    Generic ( RxDIV: NATURAL:= 10417); -- 100Mhz/DIV -> 9600 baud
    Port (  piUaRxClk : in STD_LOGIC; -- Clock de entrada
            piUaRxRst : in STD_LOGIC; -- Reset
            piUaRxEna : in STD_LOGIC; -- RX Enable
            piUaRxRx : in STD_LOGIC;    -- Puerto RX
            poUaRxC: out STD_LOGIC; -- Receive complete - Hay datos para leer en el buffer poUaRxData 
            poUaRxData : out STD_LOGIC_VECTOR (8-1 downto 0);
            poUaRxBR : out STD_LOGIC;
            poUaRxRx : out STD_LOGIC
    );
end UaRx;

architecture A_UaRx of UaRx is

Type TStates is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
signal state, next_state: TStates;
signal brgrst: STD_LOGIC := '1';
signal brgclk: STD_LOGIC;
signal latch: STD_LOGIC_VECTOR(8-1 downto 0);


begin

   instUaRxBRG: entity work.BaudRateGen(A_BaudRateGen)
      generic map( NBits => 14, Max => RxDIV, First => RxDIV/2)
      port map(piBRGClk => piUaRxClk, piBRGEna => '1', piBRGRst => brgrst, poBRGO => brgclk);

    SYNC_PROC : process (piUaRxClk, piUaRxRst)
    begin
        if rising_edge(piUaRxClk) then
            if piUaRxRst = '1' then
                state <= S0;
            else
                state <= next_state;
            end if;
        end if; 
    end process SYNC_PROC;
    
    
    NEXT_STATE_DECODE : process (state, brgclk, piUaRxRx, piUaRxEna)
    begin
        next_state <= state;
        poUaRxC <= '0';
        brgrst <= '0';
        case (state) is
            when S0 =>  -- Espera bit start
               if (piUaRxRx = '0') and (piUaRxEna = '1') then
                    brgrst <= '1';
                    next_state <= S1;
                end if;
            when S1 =>  -- Chequeo que es bit start tras medio periodo
               if brgclk = '1' then
                  if piUaRxRx = '0' then
                     next_state <= S2;
                  else
                     next_state <= S0;
                  end if;
               end if;
            when S2 => -- recepcion de datos - bit 0
                if brgclk = '1' then
                    latch(0) <= piUaRxRx;
                    next_state <= S3;
                end if;
            when S3 => -- recepcion de datos - bit 1
                if brgclk = '1' then
                    latch(1) <= piUaRxRx;
                    next_state <= S4;
                end if;
            when S4 => -- recepcion de datos - bit 2
                if brgclk = '1' then
                    latch(2) <= piUaRxRx;
                    next_state <= S5;
                end if;
            when S5 => -- recepcion de datos - bit 3
                if brgclk = '1' then
                    latch(3) <= piUaRxRx;
                    next_state <= S6;
                end if;
            when S6 => -- recepcion de datos - bit 4
                if brgclk = '1' then
                    latch(4) <= piUaRxRx;
                    next_state <= S7;
                end if;
            when S7 => -- recepcion de datos - bit 5
                if brgclk = '1' then
                    latch(5) <= piUaRxRx;
                    next_state <= S8;
                else
                    next_state <= S7;
                end if;
            when S8 => -- recepcion de datos - bit 6
                if brgclk = '1' then
                    latch(6) <= piUaRxRx;
                    next_state <= S9;
                end if;
            when S9 => -- recepcion de datos - bit 7
                if brgclk = '1' then
                    latch(7) <= piUaRxRx;
                    next_state <= S10;
                end if;
            when S10 => -- recepcion del bit de stop
               if (brgclk = '1') then
                    next_state <= S0;
                    if (piUaRxRx = '1') then
                        poUaRxData <= latch;
                        poUaRxC <= '1';
                    end if;
               end if;
            when others =>
                next_state <= S0;
        end case;
    end process NEXT_STATE_DECODE;
    
    poUaRxBR <= brgclk;
    poUaRxRx <= piUaRxRx;
    
end A_UaRx;
