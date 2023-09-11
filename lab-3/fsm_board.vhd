library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSM_board is
    Port (
        sw   : in  STD_LOGIC_VECTOR(17 downto 0);
        ledr : out STD_LOGIC_VECTOR(17 downto 0);
        key  : in  STD_LOGIC_VECTOR(3 downto 0)
    );
end FSM_board;

architecture FSM_board_architecture of FSM_board is
begin
    uut: entity work.FSM port map (
        clk   => not key(0),
        reset => not key(1),
        w     => sw(0),
        z     => ledr(0)
    );
end FSM_board_architecture;
