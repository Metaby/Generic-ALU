LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY demo IS
	PORT (
		LEDR		:	out std_logic_vector(17 DOWNTO 0);
		HEX2		:	out std_logic_vector(6 DOWNTO 0);
		HEX3		:	out std_logic_vector(6 DOWNTO 0);
		HEX4		:	out std_logic_vector(6 DOWNTO 0);
		HEX6		:	out std_logic_vector(6 DOWNTO 0);
		KEY		:	in  std_logic_vector(3 DOWNTO 0);
		SW			:	in	 std_logic_vector(17 DOWNTO 0);
		CLOCK_50 :	in  std_logic
	);
END demo;

ARCHITECTURE arch OF demo IS
	COMPONENT alu
	GENERIC (
		g_size	:	integer	:=	7
	);
	PORT (
		p_op_1		:	in  std_logic_vector(g_size DOWNTO 0);		-- Operand 1
		p_op_2		:	in  std_logic_vector(g_size DOWNTO 0);		-- Operand 2
		p_cmd			:	in  std_logic_vector(4 DOWNTO 0);			-- Operation
		p_ovflw		:	out std_logic;										-- Overflow Bit ('1' falls Overflow)
		p_cmp_f		:	out std_logic;										-- Compare Bit ('1' falls Vergleich richtig)
		p_result_lo	:	out std_logic_vector(g_size DOWNTO 0);		-- Ergebnis, unteres Byte
		p_result_hi	:	out std_logic_vector(g_size DOWNTO 0)		-- Ergebnis, oberes Byte
	);
	END COMPONENT;
	COMPONENT seven_segment_decoder
	PORT (
		bits 		: in STD_LOGIC_VECTOR(3 DOWNTO 0);
		segbits	: out STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
	END COMPONENT;
	SIGNAL s_result_lo	:	std_logic_vector(3 DOWNTO 0);
	SIGNAL s_result_hi	:	std_logic_vector(3 DOWNTO 0);
	SIGNAL s_operand_1	:	std_logic_vector(3 DOWNTO 0);
	SIGNAL s_operand_2	:	std_logic_vector(3 DOWNTO 0);
	SIGNAL s_lock_key		:	std_logic_vector(3 DOWNTO 0);
	SIGNAL s_counter		:	std_logic_vector(25 DOWNTO 0);
	SIGNAL clk				:	std_logic;
BEGIN
	test_alu	:	alu GENERIC MAP (g_size => 3) PORT MAP (s_operand_1, s_operand_2, SW(4 DOWNTO 0), LEDR(1), LEDR(0), s_result_lo, s_result_hi);
	hex_2		:	seven_segment_decoder PORT MAP (s_result_lo, HEX2);
	hex_3		:	seven_segment_decoder PORT MAP (s_result_hi, HEX3);
	hex_4		:	seven_segment_decoder PORT MAP (s_operand_2, HEX4);
	hex_6		:	seven_segment_decoder PORT MAP (s_operand_1, HEX6);
	LEDR(17 DOWNTO 14) <= s_operand_1;
	LEDR(13 DOWNTO 10) <= s_operand_2;
	LEDR(9 DOWNTO 6) <= s_result_hi;
	LEDR(5 DOWNTO 2) <= s_result_lo;
	PROCESS(CLOCK_50)
	BEGIN
		IF (CLOCK_50'event and CLOCK_50 = '1') THEN
			IF (s_counter = std_logic_vector(to_unsigned(25000000, 26))) THEN
				s_counter <= (OTHERS => '0');
				clk <= '1';
			ELSE
				s_counter <= std_logic_vector(unsigned(s_counter) + 1);
				clk <= '0';
			END IF;
		ELSE
			s_counter <= s_counter;
		END IF;
		IF (clk'event and clk = '1' and (KEY(0) = '0' or KEY(1) = '0')) THEN
			IF (KEY(0) = '0') THEN
				s_operand_2 <= std_logic_vector(unsigned(s_operand_2) + 1);
			ELSE
				s_operand_2 <= std_logic_vector(unsigned(s_operand_2) - 1);
			END IF;
		ELSE
			s_operand_2 <= s_operand_2;
		END IF;
		IF (clk'event and clk = '1' and (KEY(2) = '0' or KEY(3) = '0')) THEN
			IF (KEY(2) = '0') THEN
				s_operand_1 <= std_logic_vector(unsigned(s_operand_1) + 1);
			ELSE
				s_operand_1 <= std_logic_vector(unsigned(s_operand_1) - 1);
			END IF;
		ELSE
			s_operand_1 <= s_operand_1;
		END IF;
	END PROCESS;
END arch;