module stoplight (
  input clk,
  input rst,
  input start,
  output reg r,
  output reg y,
  output reg g
);


parameter st0 = 2'b00;
parameter st1 = 2'b01;
parameter st2 = 2'b10;
parameter st3 = 2'b11;


reg [1:0] pres_state, next_state;

always @(*) begin
    case (pres_state)
        st0: begin
            r <= 1'b1;
            y <= 1'b0;
            g <= 1'b0;
        end
        st1: begin
            r <= 1'b0;
            y <= 1'b0;
            g <= 1'b0;
        end
        st2: begin
            r <= 1'b0;
            y <= 1'b1;
            g <= 1'b0;
        end
        st3: begin
            r <= 1'b0;
            y <= 1'b0;
            g <= 1'b1;
        end
    endcase
end

// State transition logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        pres_state <= st0;
    end else if (start) begin
        pres_state <= next_state;
    end
end

always @(posedge clk) begin
    if (rst) begin
        next_state <= st0;
    end else begin
        case (pres_state)
            st0: next_state <= st1;
            st1: next_state <= st2;
            st2: next_state <= st3;
            st3: next_state <= st0;
        endcase
    end
end

endmodule
