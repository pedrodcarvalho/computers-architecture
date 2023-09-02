library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegBank_board is
    Port (
        key  : in  STD_LOGIC_VECTOR(3 downto 0);
        sw   : in  STD_LOGIC_VECTOR(17 downto 0);
        ledr : out STD_LOGIC_VECTOR(17 downto 0)
    );
end RegBank_board;

architecture RegBank_board_arch of RegBank_board is
    signal rdData1, rdData2 : STD_LOGIC_VECTOR(31 downto 0);
    signal wData : STD_LOGIC_VECTOR(31 downto 0);
begin
    uut: entity work.RegBank port map (
        clk      => not key(0),
        reset    => not key(1),
        we       => not key(2),
        rdData1  => rdData1,
        rdData2  => rdData2,
        wData    => wData,
        wrAddr   => sw(14 downto 10),
        rdAddr1  => sw(9 downto 5),
        rdAddr2  => sw(4 downto 0)
    );

    ledr(2 downto 0) <= rdData2(2 downto 0);
    ledr(7 downto 5) <= rdData1(2 downto 0);
    wData(2 downto 0) <= sw(17 downto 15);
    wData(31 downto 3) <= (others => '0');
end RegBank_board_arch;
