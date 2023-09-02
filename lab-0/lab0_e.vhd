library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Lab0 is
    port (
        LEDR : out std_logic_vector(17 downto 0);
        SW : in std_logic_vector(17 downto 0);
        HEX7 : out std_logic_vector(0 to 6);
        KEY : in std_logic_vector(3 downto 0)
    );
end entity Lab0;

architecture bhv of Lab0 is
    signal counter : integer := 0;
    signal countdown : boolean := false;
begin
    LEDR <= SW;

    process(KEY)
    begin
        if rising_edge(KEY(0)) then
            if countdown = false then
                countdown <= true;
                counter <= to_integer(unsigned(SW(6 downto 0)));
            else
                countdown <= false;
                counter <= 0;
            end if;
        end if;
    end process;

    process
    begin
        if countdown = true then
            if counter > 0 then
                counter <= counter - 1;
            end if;
        end if;
        wait for 1 sec;
    end process;

    HEX7 <= std_logic_vector(to_unsigned(counter, 7));

end architecture bhv;
