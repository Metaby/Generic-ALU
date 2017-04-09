LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_textio.all;

ENTITY tb IS
  GENERIC (
    g_size : integer := 7
  );
end ENTITY;

ARCHITECTURE arch OF tb IS
  constant timer      :   time := 100ns;
  signal tb_dividend	 :	  std_logic_vector(g_size DOWNTO 0) := (OTHERS => '0');
  signal tb_divisor	  :	  std_logic_vector(g_size DOWNTO 0) := (OTHERS => '0');
  signal tb_remain	   :	  std_logic_vector(g_size DOWNTO 0) := (OTHERS => '0');
  signal tb_result    :   std_logic_vector(g_size DOWNTO 0) := (OTHERS => '0');
  signal tb_sgnd      :   std_logic;
  signal control_result    :   std_logic_vector(g_size DOWNTO 0) := (OTHERS => '0');
  signal control_remain    :   std_logic_vector(g_size DOWNTO 0) := (OTHERS => '0');
begin
  process is
    begin
      wait for timer;
      -- signed test
      tb_sgnd <= '1';
        for i in -128 to 127 loop
          for j in -128 to 127 loop
	     	    if (tb_divisor /= std_logic_vector(to_signed(0, 8))) then
    	     	   control_result <= std_logic_vector(signed(tb_dividend) / signed(tb_divisor));
    	     	   control_remain <= std_logic_vector(signed(tb_dividend) rem signed(tb_divisor));
	     	      wait for timer;
	         	  assert(control_result = tb_result) report "division failed, false result" severity failure;
	         	  assert(control_remain = tb_remain) report "modulo failed, false result" severity failure;
	     	    end if;
	     	    tb_dividend <= std_logic_vector(to_signed(i, 8));
	     	    tb_divisor <= std_logic_vector(to_signed(j, 8));
            wait for timer;
          end loop;
      end loop;
      wait for timer;
      -- unsigned test
      tb_sgnd <= '0';
        for i in 0 to 255 loop
          for j in 0 to 255 loop
	     	    if (tb_divisor /= std_logic_vector(to_unsigned(0, 8))) then
    	     	   control_result <= std_logic_vector(unsigned(tb_dividend) / unsigned(tb_divisor));
    	     	   control_remain <= std_logic_vector(unsigned(tb_dividend) rem unsigned(tb_divisor));
	     	      wait for timer;
	         	  assert(control_result = tb_result) report "division failed, false result" severity failure;
	         	  assert(control_remain = tb_remain) report "modulo failed, false result" severity failure;
	     	    end if;
	     	    tb_dividend <= std_logic_vector(to_unsigned(i, 8));
	     	    tb_divisor <= std_logic_vector(to_unsigned(j, 8));
            wait for timer;
          end loop;
      end loop;
      wait for timer;
end process;

dut : entity work.divider
port map  (  
             p_sgnd     => tb_sgnd,
		         p_dividend	=> tb_dividend,
		         p_divisor	 => tb_divisor,
		         p_remain	  => tb_remain,
		         p_result		    => tb_result
	         );
end architecture;