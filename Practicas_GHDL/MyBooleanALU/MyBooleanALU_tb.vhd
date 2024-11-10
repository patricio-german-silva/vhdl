-- File:
-- Author:
-- Date:
-- Revision:
-- Description:

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.NUMERIC_BIT.ALL;


-- ENTITY DECLARATION ------------------------------------------------------------------------------
entity MyBooleanALU_TB is
      -- generic / port / local declatations
end entity MyBooleanALU_TB;


-- ARCHITECTURE DECLARATION ------------------------------------------------------------------------
architecture Behavioral of MyBooleanALU_TB is
     component MyBooleanALU is

              
    port ( 
      piData1 : in STD_LOGIC_VECTOR (3 downto 0);
      piData2 : in STD_LOGIC_VECTOR (3 downto 0);
      piOpCode : in STD_LOGIC_VECTOR (2 downto 0);
      poResult : out STD_LOGIC_VECTOR (3 downto 0);
      poZeroFlag : out STD_LOGIC;
      poOneFlag : out STD_LOGIC
    );
    end component MyBooleanALU;
     
    signal Data1 : STD_LOGIC_VECTOR (3 downto 0);
    signal Data2 : STD_LOGIC_VECTOR (3 downto 0);
    signal OpCode : STD_LOGIC_VECTOR (2 downto 0);
    signal Result : STD_LOGIC_VECTOR (3 downto 0);
    signal ZeroFlag : STD_LOGIC;
    signal OneFlag : STD_LOGIC;
       
begin
    instMyBooleanALU: MyBooleanALU
--         Generic map ( N => 2 )
        Port map ( piData1 => Data1,
                    piData2 => Data2,
                    piOpCode => OpCode,
                    poResult => Result,
                    poZeroFlag => ZeroFlag,
                    poOneFlag => OneFlag
                   );
                    

    process
    begin
    Data1 <= "0110";
    Data2 <= "1011";
    
    OpCode <= "000";
    wait for 10 ns;
    OpCode <= "001";
    wait for 10 ns;
    OpCode <= "010";
    wait for 10 ns;
    OpCode <= "011";
    wait for 10 ns;
    OpCode <= "100";
    wait for 10 ns;
    OpCode <= "101";
    wait for 10 ns;
    OpCode <= "110";
    wait for 10 ns;
    OpCode <= "111";
    wait for 10 ns;
    OpCode <= "000";
    wait;

    end process;                   
     
end architecture Behavioral;

