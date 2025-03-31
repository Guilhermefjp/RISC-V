module ctrl_unit (input 		 	  zero,
						input  	  [6:0] op,
						input  	  [2:0] funct3,
						input 			  funct7,
						output		 	  PCSrc,
						output reg [1:0] ResultSrc,
						output reg  	  MemWrite,
						output reg  	  ALUSrc,
						output reg [1:0] ImmSrc,
						output reg		  RegWrite,
						output reg [2:0] ALUControl);

reg [1:0] ALUOp;
wire op5;
reg Branch, Jump;
assign op5 = op[5];

assign PCSrc = (Jump & (Branch | zero));

						
//			ALU Decoder
//--------------------------------------

always @ (*) begin
	case(ALUOp)
		2'b00 : ALUControl <= 3'b000; 												// add (lw,sw)
		2'b01 : ALUControl <= 3'b001;    											// subtract (beq)
		2'b10 : begin case (funct3)
							3'b010 : ALUControl <= 3'b101;							// set less than (slt)
							3'b110 : ALUControl <= 3'b011;							// or (or)
							3'b111 : ALUControl <= 3'b010;							// and (and)
							3'b000 : begin case ({op5,funct7})
												2'b00 : ALUControl <= 3'b000; 		//add (add)
												2'b01 : ALUControl <= 3'b000; 		//add (add)
												2'b10 : ALUControl <= 3'b000; 		//add (add)
												2'b11 : ALUControl <= 3'b001; 		//subtract (sub)
												endcase
										end
							endcase
					end
	endcase
end


//			Main Decoder
//--------------------------------------

always @ (*) begin
	case (op)
		7'b0000011 : begin						// lw
							RegWrite <= 1'b1;
							ImmSrc <= 2'b00;
							ALUSrc <= 1'b1;
							MemWrite <= 1'b0;
							ResultSrc <= 2'b01;
							Branch <= 1'b0;
							Jump <= 1'b0;
							ALUOp <= 2'b00;
						 end
		7'b0100011 : begin						// sw
							RegWrite <= 1'b0;
							ImmSrc <= 2'b01;
							ALUSrc <= 1'b1;
							MemWrite <= 1'b1;
							ResultSrc <= 2'bxx;
							Branch <= 1'b0;
							Jump <= 1'b0;
							ALUOp <= 2'b00;
						 end
		7'b0110011 : begin						// R-type
							RegWrite <= 1'b1;
							ImmSrc <= 2'bxx;
							ALUSrc <= 1'b0;
							MemWrite <= 1'b0;
							ResultSrc <= 2'b00;
							Branch <= 1'b0;
							Jump <= 1'b0;
							ALUOp <= 2'b10;
						 end
		7'b1100011 : begin						// beq
							RegWrite <= 1'b0;
							ImmSrc <= 2'b10;
							ALUSrc <= 1'b0;
							MemWrite <= 1'b0;
							ResultSrc <= 2'bxx;
							Branch <= 1'b1;
							Jump <= 1'b0;
							ALUOp <= 2'b01;
						 end
		7'b0010011 : begin						// I-type ALU
							RegWrite <= 1'b1;
							ImmSrc <= 2'b00;
							ALUSrc <= 1'b1;
							MemWrite <= 1'b0;
							ResultSrc <= 2'b00;
							Branch <= 1'b0;
							Jump <= 1'b0;
							ALUOp <= 2'b10;
						 end
		7'b1101111 : begin						// jal
							RegWrite <= 1'b1;
							ImmSrc <= 2'b11;
							ALUSrc <= 1'bx;
							MemWrite <= 1'b0;
							ResultSrc <= 2'b10;
							Branch <= 1'b0;
							Jump <= 1'b1;
							ALUOp <= 2'bxx;
						 end
	endcase
end

endmodule
