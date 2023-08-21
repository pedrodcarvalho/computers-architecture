library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_tb is
end ALU_tb;

architecture ALU_tb_arch of ALU_tb is
    signal A_TB, B_TB: STD_LOGIC_VECTOR(31 downto 0);
    signal ALUCtl_TB: STD_LOGIC_VECTOR(3 downto 0);
    signal R_TB : STD_LOGIC_VECTOR(31 downto 0);
    signal Zero_TB, Overflow_TB, CarryOut_TB : STD_LOGIC;

    component ALU
        Port ( A, B : in STD_LOGIC_VECTOR(31 downto 0);
               ALUCtl : in STD_LOGIC_VECTOR(3 downto 0);
               R : out STD_LOGIC_VECTOR(31 downto 0);
               Zero : out STD_LOGIC;
               Overflow : out STD_LOGIC;
               CarryOut : out STD_LOGIC
        );
    end component;

begin
    UUT: ALU port map (
        A => A_TB,
        B => B_TB,
        ALUCtl => ALUCtl_TB,
        R => R_TB,
        Zero => Zero_TB,
        Overflow => Overflow_TB,
        CarryOut => CarryOut_TB
    );

    stimulus_proc: process
    begin
        A_TB <= "00000000000000000000000000000001";
        B_TB <= "00000000000000000000000000000010";
        ALUCtl_TB <= "0010"; -- Addition

        wait for 10 ns;

        A_TB <= "00000000000000000000000000000100";
        B_TB <= "00000000000000000000000000000011";
        ALUCtl_TB <= "0110"; -- Subtraction

        wait for 10 ns;

        A_TB <= "00000000000000000000000000000101";
        B_TB <= "00000000000000000000000000001100";
        ALUCtl_TB <= "0000"; -- Logical AND

        wait for 10 ns;

        A_TB <= "00000000000000000000000000001010";
        B_TB <= "00000000000000000000000000000101";
        ALUCtl_TB <= "0001"; -- Logical OR

        wait for 10 ns;

        A_TB <= "00000000000000000000000000001010";
        B_TB <= "00000000000000000000000000001100";
        ALUCtl_TB <= "0111"; -- Set Less Than (SLT)

        wait for 10 ns;

        A_TB <= "00000000000000000000000000001010";
        B_TB <= "00000000000000000000000000000101";
        ALUCtl_TB <= "1100"; -- NOR

        wait for 10 ns;

        -- Test cases for addition overflow and carry-out
        A_TB <= "01111111111111111111111111111110";
        B_TB <= "00000000000000000000000000000001";
        ALUCtl_TB <= "0010"; -- Addition

        wait for 10 ns;

        -- Test cases for subtraction overflow and carry-out
        A_TB <= "00000000000000000000000000000001";
        B_TB <= "00000000000000000000000000000010";
        ALUCtl_TB <= "0110"; -- Subtraction

        wait for 10 ns;
    end process stimulus_proc;
end ALU_tb_arch;
