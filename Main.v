`timescale 1ns / 1ps
module Main(	
		clk,
		reset,
		hsync,
		vsync,
		hs,
		vs,
		red,
		green,
		blue
    );
	 
	input clk;
	input reset;
	
	output reg hsync;
	output reg vsync;
	
	output reg hs;
	output reg vs;
	
	output reg [7:0] rojo;
	output reg [7:0] verde;
	output reg [7:0] azul;

	reg [9:0] h_count;
	reg [9:0] v_count;

	always @ (posedge clk) begin
		 if(!reset) begin
			  {red, green, blue} <= 24'h000000;
			  h_count <= 12'd0;
			  v_count <= 10'd0;
		 end
		else 
			begin
			{rojo, verde, azul} <= (h_count % 48 == 0) || (v_count % 48 == 0) ? 24'd0 : 24'hB93E06;			
			h_count <= (h_count == 12'd1343) ? 12'd0 : h_count + 12'd1;
			
			if(h_count == 12'd1343) begin
				  if(v_count == 10'd805) begin
						v_count <= 10'd0;
				  end
					else 	
						begin
							v_count <= v_count + 10'd1;
						end
					end
			end
			
			 hsync <= ((h_count > 12'd319) && (v_count > 10'd37)) ? 1'b1 : 1'b0;
			 hs <= ((h_count > 12'd23) && (h_count < 12'd160)) ? 1'b0 : 1'b1;
			 vs <= ((v_count > 10'd2) && (v_count < 10'd9)) ? 1'b0 : 1'b1;
			 vsync <= 1'b0;
		end
							
	endmodule
