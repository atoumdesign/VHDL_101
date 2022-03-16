library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multi_native is
	port (
		clock	: in std_logic;
		reset	: in std_logic;
		read	: in std_logic;
		write	: in std_logic;
		input_multi	: in std_logic_vector(7 downto 0);
		output_multi	: out std_logic_vector(7 downto 0)
	);
	
end multi_native;

architecture multi of multi_native is

signal a, p: std_logic_vector (7 downto 0);
signal count: std_logic_vector (1 downto 0);
begin

	process(clock) is
	begin
		if (rising_edge(clock)) then
			if (reset = '0') then
				a <= (others => '0');
				p <= (others => '0');
				count <= (others => '0');
				output_multi(7) <= '0';
				output_multi((6) downto 0) <= (others => '0');
			else
				case count is
					when "00" =>
						if (write = '1') then
							a <= input_multi;
							count <= "01";
						else
							count <= "00";
						end if;
					when "01" =>
						if (write = '0') then
							count <= "10";
						else
							count <= "01";
						end if;
					when "10" =>
						if (write = '1') then
							p <= input_multi;
							count <= "11";
						else
							count <= "10";
						end if;
					when "11" =>
						if (read = '1') then
							output_multi(6 downto 0) <= std_logic_vector(resize(unsigned(a) * unsigned(p), 7));
							output_multi(7) <= '1';
						end if;
						count <= "11";
					when others =>
						count <= "11";
				end case;
			end if;
		end if;
	end process;
end multi;