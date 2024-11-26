library ieee;

-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
use ieee.std_logic_1164.all;

-- SIGNED and UNSIGNED types, and relevant functions
use ieee.numeric_std.all;

entity ToDisplay_TB is
end entity ToDisplay_TB;


architecture Behavioral of ToDisplay_TB is
    component ToDisplay is    
    Generic( POWER_SEL_WIDTH: NATURAL:=7;
             Max: NATURAL := 100000000);    -- Ancho en bits del selector de PWM
    Port(piTDClk: in STD_LOGIC;
         piTDRst: in STD_LOGIC;
         piTDEna: in STD_LOGIC;
         piTDPowerMD: in STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
         piTDPowerMI: in STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
         piTDMode: in STD_LOGIC;
         poTDData: out STD_LOGIC_VECTOR (3 downto 0);
         poTDDot: out STD_LOGIC
         );
     end component ToDisplay;
     
     signal data : std_logic_vector(3 downto 0);
     signal poMD, poMI : std_logic_vector(6 downto 0);
     signal clk, rst, ena, mode, dot : std_logic;
           
begin
    instToDisplay: ToDisplay
        Generic map( POWER_SEL_WIDTH => 7,
                     Max => 2)
        Port map ( piTDClk => clk,
				 piTDRst => rst,
				 piTDEna => ena,
				 piTDPowerMD => poMD,
				 piTDPowerMI => poMI,
				 piTDMode => mode,
				 poTDData => data,
				 poTDDot => dot
                   );
	

	pClk: process
	begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;	
	
    process
    begin
        ena <='1';
        rst <= '0';
        poMD <= STD_LOGIC_VECTOR(TO_UNSIGNED(40, 7));
        poMI <= STD_LOGIC_VECTOR(TO_UNSIGNED(88, 7));
        mode <= '0';
        wait for 300 ns;
        poMD <= STD_LOGIC_VECTOR(TO_UNSIGNED(55, 7));
        poMI <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 7));
        mode <= '1';
        wait for 300 ns;
        poMD <= STD_LOGIC_VECTOR(TO_UNSIGNED(90, 7));
        poMI <= STD_LOGIC_VECTOR(TO_UNSIGNED(12, 7));
        mode <= '0';
    wait;
    end process;                   
     
end architecture Behavioral;



