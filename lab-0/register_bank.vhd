library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_bank is
    Port ( Clock : in STD_LOGIC;
           RegisterSelect : in STD_LOGIC_VECTOR(2 downto 0);
           WriteEnable : in STD_LOGIC;
           DataIn : in STD_LOGIC_VECTOR(7 downto 0);
           DataOut : out STD_LOGIC_VECTOR(7 downto 0));
end register_bank;

architecture Behavioral of register_bank is
    type RegisterArray is array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
    signal Registers : RegisterArray := (others => (others => '0'));
begin
    process(Clock)
    begin
        if rising_edge(Clock) then
            if WriteEnable = '1' then
                Registers(conv_integer(RegisterSelect)) <= DataIn;
            end if;
            DataOut <= Registers(conv_integer(RegisterSelect));
        end if;
    end process;
end Behavioral;
