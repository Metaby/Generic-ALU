LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_textio.all;

ENTITY tb IS
  GENERIC (
		g_size 	:	integer := 7
  );
end ENTITY;

ARCHITECTURE arch OF tb IS
  constant timer         :    time := 100ns;
  signal tb_op1	         :	   std_logic_vector(g_size DOWNTO 0) := (OTHERS => '0');
  signal tb_op2    	     :	   std_logic_vector(g_size DOWNTO 0) := (OTHERS => '0');
  signal tb_cmd          :    std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');
  signal control_result  :    std_logic;
  signal tb_result       :    std_logic;
  signal tb_sgnd         :    std_logic;
begin
  process is
    begin
      wait for timer;
      -- signed test
      tb_sgnd <= '1';
      -- tb_op1 > tb_op2
      tb_cmd <= "000";
      for i in -128 to 127 loop
        for j in -128 to 127 loop
            if (signed(tb_op1) > signed(tb_op2)) then
              control_result <= '1';
            else
              control_result <= '0';
            end if;
            wait for timer;
   		       tb_op1	<= std_logic_vector(to_signed(i,8));
	     	    tb_op2	<= std_logic_vector(to_signed(j,8));
	         	assert(control_result = tb_result) report "compare failed, false result" severity error;
            wait for timer;
        end loop;
      end loop;
      -- tb_op1 < tb_op2
      tb_cmd <= "001";
      for i in -128 to 127 loop
        for j in -128 to 127 loop
            if (signed(tb_op1) < signed(tb_op2)) then
              control_result <= '1';
            else
              control_result <= '0';
            end if;
            wait for timer;
   		       tb_op1	<= std_logic_vector(to_signed(i,8));
	     	    tb_op2	<= std_logic_vector(to_signed(j,8));
	         	assert(control_result = tb_result) report "compare failed, false result" severity error;
            wait for timer;
        end loop;
      end loop;
      -- tb_op1 >= tb_op2
      tb_cmd <= "010";
      for i in -128 to 127 loop
        for j in -128 to 127 loop
            if (signed(tb_op1) >= signed(tb_op2)) then
              control_result <= '1';
            else
              control_result <= '0';
            end if;
            wait for timer;
   		       tb_op1	<= std_logic_vector(to_signed(i,8));
	     	    tb_op2	<= std_logic_vector(to_signed(j,8));
	         	assert(control_result = tb_result) report "compare failed, false result" severity error;
            wait for timer;
        end loop;
      end loop;
      -- tb_op1 <= tb_op2
      tb_cmd <= "011";
      for i in -128 to 127 loop
        for j in -128 to 127 loop
            if (signed(tb_op1) <= signed(tb_op2)) then
              control_result <= '1';
            else
              control_result <= '0';
            end if;
            wait for timer;
   		       tb_op1	<= std_logic_vector(to_signed(i,8));
	     	    tb_op2	<= std_logic_vector(to_signed(j,8));
	         	assert(control_result = tb_result) report "compare failed, false result" severity error;
            wait for timer;
        end loop;
      end loop;
      -- tb_op1 = tb_op2
      tb_cmd <= "100";
      for i in -128 to 127 loop
        for j in -128 to 127 loop
            if (signed(tb_op1) = signed(tb_op2)) then
              control_result <= '1';
            else
              control_result <= '0';
            end if;
            wait for timer;
   		       tb_op1	<= std_logic_vector(to_signed(i,8));
	     	    tb_op2	<= std_logic_vector(to_signed(j,8));
	         	assert(control_result = tb_result) report "compare failed, false result" severity error;
            wait for timer;
        end loop;
      end loop;
      wait for timer;
      -- unsigned test
      tb_sgnd <= '0';
      -- tb_op1 > tb_op2
      tb_cmd <= "000";
      for i in 0 to 255 loop
        for j in 0 to 255 loop
            if (unsigned(tb_op1) > unsigned(tb_op2)) then
              control_result <= '1';
            else
              control_result <= '0';
            end if;
            wait for timer;
   		       tb_op1	<= std_logic_vector(to_unsigned(i,8));
	     	    tb_op2	<= std_logic_vector(to_unsigned(j,8));
	         	assert(control_result = tb_result) report "compare failed, false result" severity error;
            wait for timer;
        end loop;
      end loop;
      -- tb_op1 < tb_op2
      tb_cmd <= "001";
      for i in 0 to 255 loop
        for j in 0 to 255 loop
            if (unsigned(tb_op1) < unsigned(tb_op2)) then
              control_result <= '1';
            else
              control_result <= '0';
            end if;
            wait for timer;
   		       tb_op1	<= std_logic_vector(to_unsigned(i,8));
	     	    tb_op2	<= std_logic_vector(to_unsigned(j,8));
	         	assert(control_result = tb_result) report "compare failed, false result" severity error;
            wait for timer;
        end loop;
      end loop;
      -- tb_op1 >= tb_op2
      tb_cmd <= "010";
      for i in 0 to 255 loop
        for j in 0 to 255 loop
            if (unsigned(tb_op1) >= unsigned(tb_op2)) then
              control_result <= '1';
            else
              control_result <= '0';
            end if;
            wait for timer;
   		       tb_op1	<= std_logic_vector(to_unsigned(i,8));
	     	    tb_op2	<= std_logic_vector(to_unsigned(j,8));
	         	assert(control_result = tb_result) report "compare failed, false result" severity error;
            wait for timer;
        end loop;
      end loop;
      -- tb_op1 <= tb_op2
      tb_cmd <= "011";
      for i in 0 to 255 loop
        for j in 0 to 255 loop
            if (unsigned(tb_op1) <= unsigned(tb_op2)) then
              control_result <= '1';
            else
              control_result <= '0';
            end if;
            wait for timer;
   		       tb_op1	<= std_logic_vector(to_unsigned(i,8));
	     	    tb_op2	<= std_logic_vector(to_unsigned(j,8));
	         	assert(control_result = tb_result) report "compare failed, false result" severity error;
            wait for timer;
        end loop;
      end loop;
      -- tb_op1 = tb_op2
      tb_cmd <= "100";
      for i in 0 to 255 loop
        for j in 0 to 255 loop
            if (unsigned(tb_op1) = unsigned(tb_op2)) then
              control_result <= '1';
            else
              control_result <= '0';
            end if;
            wait for timer;
   		       tb_op1	<= std_logic_vector(to_unsigned(i,8));
	     	    tb_op2	<= std_logic_vector(to_unsigned(j,8));
	         	assert(control_result = tb_result) report "compare failed, false result" severity error;
            wait for timer;
        end loop;
      end loop;
      wait for timer;
end process;

dut : entity work.word_comparator
port map  (  
             p_op_1      => tb_op1,
             p_op_2      => tb_op2,
             p_cmd      => tb_cmd,
             p_sgnd     => tb_sgnd,
             p_result      => tb_result
	         );
end architecture;
