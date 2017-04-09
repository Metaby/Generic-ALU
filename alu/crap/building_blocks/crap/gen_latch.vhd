LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gen_latch IS
	GENERIC (
		size	:	integer := 7
	);
	PORT (
		clk	:	in std_logic;
		x		:	in std_logic_vector(size DOWNTO 0);
		q		:	out std_logic_vector(size DOWNTO 0)
	);
END gen_latch;

ARCHITECTURE arch OF gen_latch IS
BEGIN
	PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
				q <= x;
		END IF;
	END PROCESS;
END arch;