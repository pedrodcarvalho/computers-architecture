library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port (
        A, B : in STD_LOGIC_VECTOR(31 downto 0);
        ALUCtl : in STD_LOGIC_VECTOR(3 downto 0);
        R : out STD_LOGIC_VECTOR(31 downto 0);
        Zero : out STD_LOGIC;
        Overflow : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end ALU;

architecture ALU_arch of ALU is
    signal RAux: STD_LOGIC_VECTOR(31 downto 0);

begin
    process(ALUCtl, A, B)
        variable temp : STD_LOGIC_VECTOR(32 downto 0);
        variable carry : STD_LOGIC := '0';
    begin
        case ALUCtl is
            when "0010" => -- Addition
                temp := ('0' & A) + ('0' & B);
                RAux <= temp(31 downto 0);
                carry := temp(8);
            when "0110" => -- Subtraction
                temp := ('0' & A) - ('0' & B);
                RAux <= temp(31 downto 0);
                carry := not temp(8);
            when "0000" => -- Logical AND
                RAux <= A and B;
            when "0001" => -- Logical OR
                RAux <= A or B;
            when "0111" => -- Set Less Than (SLT)
                if A < B then
                    RAux <= "00000000000000000000000000000001";
                else
                    RAux <= "00000000000000000000000000000000";
                end if;
                carry := '0';
            when "1100" => -- NOR
                RAux <= not (A or B);
                carry := '0';
            when others => -- Default case
                RAux <= (others => '0');
                carry := '0';
        end case;

        if (A(7) xor B(7)) = '1' and (A(7) xor RAux(7)) = '1' then
            Overflow <= '1';
        else
            Overflow <= '0';
        end if;

        Cout <= carry;
    end process;

    R <= RAux;
    Zero <= '1' when RAux = "00000000" else '0';
end ALU_arch;
