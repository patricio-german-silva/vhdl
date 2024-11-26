----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:04:23 PM
-- Design Name: 
-- Module Name: CommProtRx_TB - Behavioral
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

entity CommProtRx_TB is
--  Port ( );
end CommProtRx_TB;

architecture Behavioral of CommProtRx_TB is
   component CommProtRx is
    Generic(HEADER_CHAR : NATURAL := 67;                               -- D
            TRAILER_CHAR : NATURAL := 90;                              -- Z
            TIMEOUT: NATURAL := 1000000);                                 -- Timepot en ciclos de reloj, si no se completó un paquete se resetea la comunicación 
    Port (  piCPRxClk : in STD_LOGIC;                                  -- clock
            piCPRxRdy : in STD_LOGIC;                                  -- Caracter de entrada listo
            piCPRxRst : in STD_LOGIC;                                  -- Reset
            piCPRxEna : in STD_LOGIC;                                  -- Enable
            piCPRxRx : in STD_LOGIC_VECTOR(7 downto 0);                -- Byte de entrada
            poCPRxCmd : out STD_LOGIC_VECTOR(7 downto 0);              -- Comnado de entrada, 1 byte
            poCPRxData : out STD_LOGIC_VECTOR(15 downto 0);            -- Datos de entrada
            poCPRxC : out STD_LOGIC                                    -- Nuevo paquete de comando listo
    );
   end component CommProtRx;

   signal clk, rst, ena, c, rdy, rdyena: STD_LOGIC;
   signal data: STD_LOGIC_VECTOR(15 downto 0);
   signal cmd, rx: STD_LOGIC_VECTOR(7 downto 0);
begin

       instCommProtRx: CommProtRx
       generic map(HEADER_CHAR => 67,
                   TRAILER_CHAR => 90,
                   TIMEOUT => 10)
       Port map ( piCPRxClk => clk,
            piCPRxRst => rst,
            piCPRxRdy => rdy,
            piCPRxEna => ena,
            piCPRxRx => rx,
            poCPRxCmd => cmd,
            poCPRxC => c,
            poCPRxData => data);

   pClk: process
	begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;	


   pRdy: process
	begin
		rdy <= rdyena;
		wait for 11 ns;
		rdy <= '0';
		wait for 11 ns;
	end process;	


    process
    begin
       rst <= '1';
       ena <= '0';
       rdyena <= '1';
       wait for 33 ns;
       rst <= '0';
       ena <= '1';
       
       wait until falling_edge(rdy);
       rx <= STD_LOGIC_VECTOR(to_unsigned(67, 8)); -- Header
       wait until falling_edge(rdy);
       rx <= "00001110";  -- CMD
       wait until falling_edge(rdy);
       rx <= "00110011";  -- Data
       wait until falling_edge(rdy);
       rx <= "01010101";  -- Data
       wait until falling_edge(rdy);
       rx <= STD_LOGIC_VECTOR(to_unsigned(90, 8)); -- Trailer

       -- Worng header
       wait until falling_edge(rdy);
       rx <= STD_LOGIC_VECTOR(to_unsigned(37, 8)); -- Header
       wait until falling_edge(rdy);
       rx <= "00001101";  -- CMD
       wait until falling_edge(rdy);
       rx <= "00110011";  -- Data
       wait until falling_edge(rdy);
       rx <= "01010101";  -- Data
       wait until falling_edge(rdy);
       rx <= STD_LOGIC_VECTOR(to_unsigned(90, 8)); -- Trailer
       
       -- Timeout
       wait until falling_edge(rdy);
       rx <= STD_LOGIC_VECTOR(to_unsigned(67, 8)); -- Header
       wait until falling_edge(rdy);
       rx <= "00011111";  -- CMD
       wait until falling_edge(rdy);
       rx <= "00000011";  -- Data
       rdyena <= '0';
       wait for 180 ns;
       rdyena <= '1';
       wait until falling_edge(rdy);
       rx <= "00000000";  -- Data
       wait until falling_edge(rdy);
       rx <= STD_LOGIC_VECTOR(to_unsigned(90, 8)); -- Trailer


       -- OK
       wait until falling_edge(rdy);
       rx <= STD_LOGIC_VECTOR(to_unsigned(67, 8)); -- Header
       wait until falling_edge(rdy);
       rx <= "00001011";  -- CMD
       wait until falling_edge(rdy);
       rx <= "00000001";  -- Data
       wait until falling_edge(rdy);
       rx <= "11111111";  -- Data
       wait until falling_edge(rdy);
       rx <= STD_LOGIC_VECTOR(to_unsigned(90, 8)); -- Trailer
       
       -- Worng trailer
       wait until falling_edge(rdy);
       rx <= STD_LOGIC_VECTOR(to_unsigned(67, 8)); -- Header
       wait until falling_edge(rdy);
       rx <= "00000111";  -- CMD
       wait until falling_edge(rdy);
       rx <= "00110011";  -- Data
       wait until falling_edge(rdy);
       rx <= "01010101";  -- Data
       wait until falling_edge(rdy);
       rx <= STD_LOGIC_VECTOR(to_unsigned(50, 8)); -- Trailer

       wait for 33 ns;

       wait;

    end process;

end Behavioral;
