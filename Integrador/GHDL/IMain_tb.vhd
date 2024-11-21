----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:04:23 PM
-- Design Name: 
-- Module Name: CmdParser_TB - Behavioral
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

entity CmdParser_TB is
--  Port ( );
end CmdParser_TB;

architecture Behavioral of CmdParser_TB is
   component CmdParser is
    Generic(HEADER_CHAR : NATURAL := 67;                             -- D
            TRAILER_CHAR : NATURAL := 90);                           -- Z
    Port (  piCPClk : in STD_LOGIC;                                  -- "clock", caracter de entrada listo
            piCPRst : in STD_LOGIC;                                  -- Reset
            piCPRx : in STD_LOGIC_VECTOR(7 downto 0);                -- Byte de entrada
            poCPCmd : out STD_LOGIC_VECTOR(7 downto 0);              -- Comnado de entrada, 1 byte
            poCPData : out STD_LOGIC_VECTOR(15 downto 0);   -- Valor de entrada
            poCPC : out STD_LOGIC                                    -- Nuevo paquete de comando listo
    );
   end component CmdParser;

   signal clk, rst, c: STD_LOGIC;
   signal data: STD_LOGIC_VECTOR(15 downto 0);
   signal cmd, rx: STD_LOGIC_VECTOR(7 downto 0);
begin

       instCmdParser: CmdParser
       generic map(HEADER_CHAR => 67,
                   TRAILER_CHAR => 90)
       Port map ( piCPClk => clk,
            piCPRst => rst,
            piCPRx => rx,
            poCPCmd => cmd,
            poCPC => c,
            poCPData => data);

   pClk: process
	begin
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
	end process;	


    process
    begin
       rst <= '1';
       wait for 33 ns;
       rst <= '0';
       
       wait until falling_edge(clk);
       rx <= STD_LOGIC_VECTOR(to_unsigned(67, 8)); -- Header
       wait until falling_edge(clk);
       rx <= "00001110";  -- CMD
       wait until falling_edge(clk);
       rx <= "00110011";  -- Data
       wait until falling_edge(clk);
       rx <= "01010101";  -- Data
       wait until falling_edge(clk);
       rx <= STD_LOGIC_VECTOR(to_unsigned(90, 8)); -- Trailer

       -- Worng header
       wait until falling_edge(clk);
       rx <= STD_LOGIC_VECTOR(to_unsigned(37, 8)); -- Header
       wait until falling_edge(clk);
       rx <= "00001101";  -- CMD
       wait until falling_edge(clk);
       rx <= "00110011";  -- Data
       wait until falling_edge(clk);
       rx <= "01010101";  -- Data
       wait until falling_edge(clk);
       rx <= STD_LOGIC_VECTOR(to_unsigned(90, 8)); -- Trailer
       
       -- OK
       wait until falling_edge(clk);
       rx <= STD_LOGIC_VECTOR(to_unsigned(67, 8)); -- Header
       wait until falling_edge(clk);
       rx <= "00001011";  -- CMD
       wait until falling_edge(clk);
       rx <= "00000001";  -- Data
       wait until falling_edge(clk);
       rx <= "11111111";  -- Data
       wait until falling_edge(clk);
       rx <= STD_LOGIC_VECTOR(to_unsigned(90, 8)); -- Trailer
       
       -- Worng trailer
       wait until falling_edge(clk);
       rx <= STD_LOGIC_VECTOR(to_unsigned(67, 8)); -- Header
       wait until falling_edge(clk);
       rx <= "00000111";  -- CMD
       wait until falling_edge(clk);
       rx <= "00110011";  -- Data
       wait until falling_edge(clk);
       rx <= "01010101";  -- Data
       wait until falling_edge(clk);
       rx <= STD_LOGIC_VECTOR(to_unsigned(50, 8)); -- Trailer

       -- oK
       wait until falling_edge(clk);
       rx <= STD_LOGIC_VECTOR(to_unsigned(67, 8)); -- Header
       wait until falling_edge(clk);
       rx <= "00011111";  -- CMD
       wait until falling_edge(clk);
       rx <= "00000011";  -- Data
       wait until falling_edge(clk);
       rx <= "00000000";  -- Data
       wait until falling_edge(clk);
       rx <= STD_LOGIC_VECTOR(to_unsigned(90, 8)); -- Trailer


       wait for 33 ns;

       wait;

    end process;

end Behavioral;
