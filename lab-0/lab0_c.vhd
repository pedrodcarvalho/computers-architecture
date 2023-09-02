-- Um loop for simples foi utilizado para manter o código claro e direto, sem repetições.

library ieee;
use ieee.std_logic_1164.all;

entity Lab0 is
    port (
        LEDR : out std_logic_vector(17 downto 0);
        SW : in std_logic_vector(17 downto 0);
        HEX7 : out std_logic_vector(0 to 6);
        KEY : in std_logic_vector(3 downto 0)
    );
end entity Lab0;

architecture bhv of Lab0 is
begin
    LEDR(0) <= '0';

    process(SW)
    begin
        for i in 1 to 17 loop
            LEDR(i) <= SW(i) xor SW(i-1);
        end loop;
    end process;

    with KEY select
        HEX7 <= "0000001" when "0000",
                "1001111" when "0001",
                "0010010" when "0010",
                "0000110" when "0011",
                "1001100" when "0100",
                "0100100" when "0101",
                "0100000" when "0110",
                "0001111" when "0111",
                "0000000" when "1000",
                "0000100" when "1001",
                "0001000" when "1010",
                "1100000" when "1011",
                "0110001" when "1100",
                "1000010" when "1101",
                "0110000" when "1110",
                "0111000" when "1111",
                "1111111" when others;

end architecture bhv;
