-- Datei:	selector_4_to_1.vhd
-- Autor:	Max Brand
-- Datum: 14.07.2016

-- Code-Konventionen
-- Variablenbenennung
-- g_<name> entspricht Generic
-- p_<name> entspricht Port
-- c_<name> entspricht Konstante
-- s_<name> entspricht Signal

-- Pakete
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Entity Port
ENTITY selector_4_to_1 IS
	PORT (
		p_ctrl	:	in std_logic_vector(1 DOWNTO 0);
		p_op		:	in std_logic_vector(3 DOWNTO 0);
		p_result	:	out std_logic
	);
END selector_4_to_1;

-- Entity Architektur
ARCHITECTURE arch OF selector_4_to_1 IS
BEGIN
  p_result <= p_op(0) when (p_ctrl = "00") else
         			p_op(1) when (p_ctrl = "01") else
         			p_op(2) when (p_ctrl = "10") else
         			p_op(3);
END arch;
