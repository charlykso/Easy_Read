using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace API.Migrations
{
    public partial class edited_some_models : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Cover_Img_url",
                table: "Books",
                newName: "Front_Cover_Img_url");

            migrationBuilder.AddColumn<string>(
                name: "Back_Cover_Img_url",
                table: "Books",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Gender",
                table: "Authors",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(20)",
                oldMaxLength: 20,
                oldNullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Back_Cover_Img_url",
                table: "Books");

            migrationBuilder.RenameColumn(
                name: "Front_Cover_Img_url",
                table: "Books",
                newName: "Cover_Img_url");

            migrationBuilder.AlterColumn<string>(
                name: "Gender",
                table: "Authors",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10,
                oldNullable: true);
        }
    }
}
