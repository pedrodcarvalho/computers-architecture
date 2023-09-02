library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegBank is
    Port (
        clk, reset, we : in STD_LOGIC;
        rdAddr1, rdAddr2, wrAddr : in STD_LOGIC_VECTOR(4 downto 0);
        wData : in STD_LOGIC_VECTOR(31 downto 0);
        rdData1, rdData2 : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RegBank;

architecture RegBank_arch of RegBank is
    type RegisterArray is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal registers : RegisterArray := (others => (others => '0'));
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                registers <= (others => (others => '0'));
            elsif we = '1' then
                registers(conv_integer(wrAddr)) <= wData;
            end if;
        end if;
    end process;

    rdData1 <= registers(conv_integer(rdAddr1));
    rdData2 <= registers(conv_integer(rdAddr2));
end RegBank_arch;
