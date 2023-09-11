library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSM is
    Port (
        clk   : in  std_logic;
        reset : in  std_logic;
        w     : in  std_logic;
        z     : out std_logic
    );
end FSM;

architecture FSM_architecture of FSM is
    type state_type is (A, B, C, D, E, F, G, H, I);
    signal current_state, next_state : state_type;

begin
    process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                current_state <= A;
            else
                current_state <= next_state;
            end if;
        end if;
    end process;

    process (current_state, w)
    begin
        case current_state is
            when A =>
                if w = '0' then
                    next_state <= B;
                elsif w = '1' then
                    next_state <= F;
                else
                    next_state <= A;
                end if;

            when B =>
                if w = '0' then
                    next_state <= C;
                elsif w = '1' then
                    next_state <= F;
                else
                    next_state <= A;
                end if;

            when C =>
                if w = '0' then
                    next_state <= D;
                elsif w = '1' then
                    next_state <= F;
                else
                    next_state <= A;
                end if;

            when D =>
                if w = '0' then
                    next_state <= E;
                elsif w = '1' then
                    next_state <= F;
                else
                    next_state <= A;
                end if;

            when E =>
                if w = '0' then
                    next_state <= E;
                elsif w = '1' then
                    next_state <= F;
                else
                    next_state <= A;
                end if;

            when F =>
                if w = '0' then
                    next_state <= B;
                elsif w = '1' then
                    next_state <= G;
                else
                    next_state <= A;
                end if;

            when G =>
                if w = '0' then
                    next_state <= B;
                elsif w = '1' then
                    next_state <= H;
                else
                    next_state <= A;
                end if;

            when H =>
                if w = '0' then
                    next_state <= B;
                elsif w = '1' then
                    next_state <= I;
                else
                    next_state <= A;
                end if;

            when I =>
                if w = '0' then
                    next_state <= B;
                elsif w = '1' then
                    next_state <= I;
                else
                    next_state <= A;
                end if;

            when others =>
                next_state <= A;
        end case;
    end process;

    process (current_state)
    begin
        case current_state is
            when I =>
                z <= '1';
            when E =>
                z <= '1';
            when others =>
                z <= '0';
        end case;
    end process;

end FSM_architecture;
