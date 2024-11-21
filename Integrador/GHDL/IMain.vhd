----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2024 04:37:44 PM
-- Design Name: 
-- Module Name: CommProtRx - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Protocolo de frame de ancho fijo, 1 byte de header
--              1 byte de trailer, sin checksum - Receiver
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

entity CommProtRx is
    Generic(HEADER_CHAR : NATURAL := 67;                             -- D
            TRAILER_CHAR : NATURAL := 90);                           -- Z
    Port (  piCPClk : in STD_LOGIC;                                  -- "clock", poUaRxC en 1 indica caracter de entrada listo
            piCPRst : in STD_LOGIC;                                  -- Reset
            piCPRx : in STD_LOGIC_VECTOR(7 downto 0);                -- Byte de entrada
            poCPCmd : out STD_LOGIC_VECTOR(7 downto 0);              -- Comnado de entrada, 1 byte
            poCPData : out STD_LOGIC_VECTOR(15 downto 0);   -- Valor de entrada
            poCPC : out STD_LOGIC                                    -- Nuevo paquete de comando listo
    );
end CommProtRx;

architecture A_CommProtRx of CommProtRx is
Type TStates is (S0, S1, S2, S3, S4);
signal state, next_state: TStates;
signal cmd: STD_LOGIC_VECTOR(7 downto 0);
signal data: STD_LOGIC_VECTOR(15 downto 0);

begin

    SYNC_PROC : process (piCPClk)
    begin
        if rising_edge(piCPClk) then
            if (piCPRst = '1') then
                state <= S0;
            else
                state <= next_state;
            end if;
        end if; 
    end process;
    

    NEXT_STATE_DECODE : process (state, piCPRx)
    begin
        poCPC <= '0';
        case (state) is
            when S0 =>  -- Header
                if piCPRx = STD_LOGIC_VECTOR(to_unsigned(HEADER_CHAR, 8)) then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 =>
                cmd <= piCPRx;
                next_state <= S2;
            when S2 =>
                data(15 downto 8) <= piCPRx;
                next_state <= S3;
            when S3 =>
                data(7 downto 0) <= piCPRx;
                next_state <= S4;
            when S4 =>  --Trailer
                if piCPRx = STD_LOGIC_VECTOR(to_unsigned(TRAILER_CHAR, 8)) then
                    poCPC <= '1';
                    poCPCmd <= cmd;
                    poCPData <= data;
                end if;
                next_state <= S0;
            when others =>
                next_state <= S0;
        end case;
    end process; 

end A_CommProtRx;

