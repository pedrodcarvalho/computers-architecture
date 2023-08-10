library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A, B : in STD_LOGIC_VECTOR(7 downto 0);
           ALUOp : in STD_LOGIC_VECTOR(2 downto 0);
           Result : out STD_LOGIC_VECTOR(7 downto 0);
           ZeroFlag : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
begin
    process(ALUOp, A, B)
        variable temp : STD_LOGIC_VECTOR(8 downto 0);
    begin
        case ALUOp is
            when "000" => -- Addition
                temp := ('0' & A) + ('0' & B);
                Result <= temp(7 downto 0);
            when "001" => -- Subtraction
                temp := ('0' & A) - ('0' & B);
                Result <= temp(7 downto 0);
            when "010" => -- Logical AND
                Result <= A and B;
            when "011" => -- Logical OR
                Result <= A or B;
            when others =>
                Result <= (others => '0');
        end case;

        ZeroFlag <= '1' when Result = "00000000" else '0';
    end process;
end Behavioral;
