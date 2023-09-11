library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSM_tb is
end FSM_tb;

architecture FSM_tb_architecture of FSM_tb is
    signal clk, reset, w, z : std_logic;
begin
    UUT: entity work.FSM
        port map (
            clk   => clk,
            reset => reset,
            w     => w,
            z     => z
        );

    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        reset <= '0';
        wait;
    end process;

    process
    begin
        wait for 20 ns;

        -- Test Case 1
        w <= '0';
        wait for 10 ns;
        assert z = '0' report "Test Case 1 Failed" severity failure;

        -- Test Case 2
        w <= '0';
        wait for 10 ns;
        assert z = '0' report "Test Case 2 Failed" severity failure;

        -- Test Case 3
        w <= '0';
        wait for 10 ns;
        assert z = '0' report "Test Case 3 Failed" severity failure;

        -- Test Case 4
        w <= '0';
        wait for 10 ns;
        assert z = '0' report "Test Case 4 Failed" severity failure;

        -- Test Case 5
        w <= '1';
        wait for 10 ns;
        assert z = '1' report "Test Case 5 Failed" severity failure;

        wait;
    end process;
end FSM_tb_architecture;
