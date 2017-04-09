LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gen_mux IS
	GENERIC (
		size	:	integer := 7
	);
	PORT (
		sel	:	in std_logic;
		op1	:	in std_logic_vector(size DOWNTO 0);
		op2	:	in std_logic_vector(size DOWNTO 0);
		res	:	out std_logic_vector(size DOWNTO 0)
	);
END gen_mux;

ARCHITECTURE arch OF gen_mux IS
BEGIN
  res <= op1 when sel = '0' else op2;
END arch;