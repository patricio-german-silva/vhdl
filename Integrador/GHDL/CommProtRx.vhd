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
    Generic(HEADER_CHAR : NATURAL := 68;                               -- D
            TRAILER_CHAR : NATURAL := 90;                              -- Z
            TIMEOUT: NATURAL := 1000000);                              -- Timeout en ciclos de reloj, si no se completó un paquete se resetea la comunicación 
    Port (  piCPRxClk : in STD_LOGIC;                                  -- clock
            piCPRxRst : in STD_LOGIC;                                  -- Reset
            piCPRxEna : in STD_LOGIC;                                  -- Enable
            piCPRxRdy : in STD_LOGIC;                                  -- Caracter de entrada listo
            piCPRxRx : in STD_LOGIC_VECTOR(7 downto 0);                -- Byte de entrada
            poCPRxCmd : out STD_LOGIC_VECTOR(7 downto 0);              -- Comnado, 1 byte
            poCPRxData : out STD_LOGIC_VECTOR(15 downto 0);            -- Dato, 2 byte
            poCPRxC : out STD_LOGIC                                    -- Se recibió un nuevo paquete de comando
    );
end CommProtRx;

architecture A_CommProtRx of CommProtRx is
Type TStates is (S0, S1, S2, S3, S4);
signal state, next_state: TStates;
signal cmd, r_cmd: STD_LOGIC_VECTOR(7 downto 0);
signal data, r_data: STD_LOGIC_VECTOR(15 downto 0);
signal tout: STD_LOGIC := '0';
signal rxrdy: STD_LOGIC := '0';

begin


    instTTrigger: entity work.TTrigger(A_TTrigger)
        generic map(NBits => 20, Max => TIMEOUT) 
        port map(piTTClk => piCPRxClk, piTTEna => piCPRxEna, piTTRst => piCPRxRdy, poTTO => tout);

    
    SYNC_PROC : process(piCPRxClk)
    begin
        if rising_edge(piCPRxClk) then
            rxrdy <= piCPRxRdy;
            if (piCPRxRst = '1') or (tout = '1') then
                state <= S0;
            else
                state <= next_state;
                r_cmd <= cmd;
                r_data <= data;
            end if;
        end if;
    end process;


    NEXT_STATE_DECODE : process (state, rxrdy)
    begin
        cmd <= r_cmd;
        data <= r_data;
        poCPRxC <= '0';
        next_state <= state;
        case (state) is
            when S0 =>  -- Header
                if rxrdy = '1' then
                    if piCPRxRx = STD_LOGIC_VECTOR(to_unsigned(HEADER_CHAR, 8)) then
                        next_state <= S1;
                    else
                        next_state <= S0;
                    end if;
                end if;
            when S1 =>
                if rxrdy = '1' then
                    cmd <= piCPRxRx;
                    next_state <= S2;
                end if;
            when S2 =>
                if rxrdy = '1' then
                    data(15 downto 8) <= piCPRxRx;
                    next_state <= S3;
                end if;
            when S3 =>
                if rxrdy = '1' then
                    data(7 downto 0) <= piCPRxRx;
                    next_state <= S4;
                end if;
            when S4 =>  --Trailer
                if rxrdy = '1' then
                    if piCPRxRx = STD_LOGIC_VECTOR(to_unsigned(TRAILER_CHAR, 8)) then
                        poCPRxC <= '1';
                    end if;
                    next_state <= S0;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process; 
    
    
    poCPRxCmd <= r_cmd;
    poCPRxData <= r_data;


end A_CommProtRx;
