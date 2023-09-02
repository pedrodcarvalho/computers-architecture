library ieee;
use ieee.std_logic_1164.all;

entity Lab0 is
    port (
        LEDR : out std_logic_vector(17 downto 0);
        SW : in std_logic_vector(17 downto 0);
        HEX7 : out std_logic_vector(0 to 13);
        KEY : in std_logic_vector(3 downto 0)
    );
end entity Lab0;

architecture bhv of Lab0 is
    signal hex_display : std_logic_vector(6 downto 0);
    signal hex_display2 : std_logic_vector(6 downto 0);

begin
    LEDR <= SW;

    with KEY select
        hex_display <= "0000001" when "0000",
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

    hex_display2 <= hex_display when KEY = "0000" else
                    "0111111" when others;

    HEX7 <= hex_display & hex_display2;
end architecture bhv;
