library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Lab0 is
    port (
        LEDR : out std_logic_vector(17 downto 0);
        SW : in std_logic_vector(35 downto 0);
        HEX7 : out std_logic_vector(27 downto 0);
        KEY : in std_logic_vector(3 downto 0)
    );
end entity Lab0;

architecture bhv of Lab0 is
    signal num1 : unsigned(6 downto 0);
    signal num2 : unsigned(6 downto 0);
    signal sum : unsigned(13 downto 0);
begin
    num1 <= unsigned(SW(35 downto 28));
    num2 <= unsigned(SW(27 downto 20));
    sum <= num1 + num2;

    LEDR <= SW(17 downto 0);

    with KEY select
        HEX7 <= std_logic_vector(to_unsigned(0, 7)) when "0000",
                std_logic_vector(to_unsigned(to_integer(num1), 7)) when "0001",
                std_logic_vector(to_unsigned(to_integer(num2), 7)) when "0010",
                std_logic_vector(to_unsigned(to_integer(sum), 7)) when "0011",
                std_logic_vector(to_unsigned(to_integer(sum), 7)) when others;
end architecture bhv;
