LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY selector_4_to_1 IS
	PORT (
		ctl	:	in std_logic_vector(1 DOWNTO 0);
		op		:	in std_logic_vector(3 DOWNTO 0);
		res	:	out std_logic
	);
END selector_4_to_1;

ARCHITECTURE arch OF selector_4_to_1 IS
BEGIN
	PROCESS (ctl)
	BEGIN
		IF ctl = "00" THEN
			res <= op(0);
		ELSIF ctl = "01" THEN
			res <= op(1);
		ELSIF ctl = "10" THEN
			res <= op(2);
		ELSIF ctl = "11" THEN
			res <= op(3);
		END IF;
	END PROCESS;
END arch;