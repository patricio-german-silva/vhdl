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

signal RstBR, BRRdy: std_logic;

Type state_type is (stIdle, stStr, stD0, stD1, stD2, stD3, stD4, stD5, stD6, stD7, stStp);

signal state, next_state : state_type;
--Declare internal signals for all outputs of the state-machine
signal poByteRdy_i : std_logic;  -- example output signal
signal poByte_i, poByte_n : std_logic_vector(7 downto 0);

signal brCount : unsigned(14-1 downto 0);

begin

--instMyBaudRate: entity work.MyModuleCounter(Behavioral)
--    generic map(NBits => BRBits, Max => BR)
--    port map(piUaRxClk => piUaRxClk, piEna => '1', piUaRxRst => RstBR, poX => X, poX2 => X2);

SYNC_PROC: process (piUaRxClk)
begin
  if rising_edge(piUaRxClk) then
     if (piUaRxRst = '1') then
        state <= stIdle;
        poUaRxC <= '0';
     else
        state <= next_state;
        poUaRxC <= poByteRdy_i;
        poByte_n <= poByte_i;
     end if;
  end if;
end process;


NEXT_STATE_DECODE: process (state, piUaRxRx, BRRdy)
begin
    RstBR <= '0';  
    next_state <= state;  --default is to stay in current state
    poByteRdy_i <= '0';
    poByte_i <= poByte_n;
       
    case (state) is
        when stIdle =>
            if piUaRxRx = '0' then
                next_state <= stStr;
                RstBR <= '1';
            end if;
        when stStr =>
            if BRRdy = '1' then
--            if X = '1' then
                if piUaRxRx = '0' then
                    next_state <= stD0;
                else
                    next_state <= stIdle;
                end if;    
            end if;
        when stD0 =>
            if BRRdy = '1' then
                poByte_i(0) <= piUaRxRx;
                next_state <= stD1;
             end if;
        when stD1 =>
            if BRRdy = '1' then
                poByte_i(1) <= piUaRxRx;
                next_state <= stD2;
             end if;
        when stD2 =>
            if BRRdy = '1' then
                poByte_i(2) <= piUaRxRx;
                next_state <= stD3;
             end if;
        when stD3 =>
            if BRRdy = '1' then
                poByte_i(3) <= piUaRxRx;
                next_state <= stD4;
             end if;
        when stD4 =>
            if BRRdy = '1' then
                poByte_i(4) <= piUaRxRx;
                next_state <= stD5;
             end if;
        when stD5 =>
            if BRRdy = '1' then
                poByte_i(5) <= piUaRxRx;
                next_state <= stD6;
             end if;
        when stD6 =>
            if BRRdy = '1' then
                poByte_i(6) <= piUaRxRx;
                next_state <= stD7;
             end if;
        when stD7 =>
            if BRRdy = '1' then
                poByte_i(7) <= piUaRxRx;
                next_state <= stStp;
             end if;
        when stStp =>
            if BRRdy = '1' then
                next_state <= stIdle;
                if piUaRxRx = '1' then
                    poByteRdy_i <= '1';
                end if;        
            end if;   
        when others =>
            next_state <= stIdle;
    end case;
end process;

poUaRxData <= poByte_n;



BRGenerator: process(piUaRxClk, RstBR)
begin
    if RstBR = '1' then
        brCount <= to_unsigned((100000000/9600)/2, 14);
    elsif rising_edge(piUaRxClk) then
        brCount <= brCount - to_unsigned(1, 14);
        if brCount = to_unsigned(0, 14) then
            brCount <= to_unsigned(100000000/9600, 14);
        end if;
    end if;        
end process;

BRRdy <= '1' when brCount = to_unsigned(0, 14) else '0';

end A_UaRx;
