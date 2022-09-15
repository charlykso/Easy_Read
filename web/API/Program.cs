using System.Text;
using API.Models;
using API.Repo;
using API.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json.Serialization;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.Filters;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

//for EF-core
builder.Services.AddDbContext<EasyReaderDBContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("EasyReaderAppCon"));
});

builder.Services.AddHttpClient();

//For JWTBearer
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
// .AddCookie(cfg => cfg.SlidingExpiration = true)
.AddJwtBearer(options =>
{
    try
    {
        // options.Authority = "https://localhost:7144";
        options.SaveToken = true;
        options.RequireHttpsMetadata = false;
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ClockSkew = TimeSpan.Zero,
            ValidateIssuerSigningKey = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]))
        };
    }
    catch (System.Exception ex)
    {

        Console.WriteLine(ex.Message);
    }
});


//enable CORS

builder.Services.AddCors(c =>
{
    c.AddPolicy("AllowAllOrigin", options => options.AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());
});

//For Json Serializer
builder.Services.AddControllersWithViews().AddNewtonsoftJson(options =>
options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore)
.AddNewtonsoftJson(options => options.SerializerSettings.ContractResolver = new DefaultContractResolver());

builder.Services.AddScoped<IUser, UserServices>();
builder.Services.AddScoped<IAuthor, AuthourServices>();
builder.Services.AddScoped<IBook, BookServices>();
builder.Services.AddScoped<IBook_User, BookUserServices>();

builder.Services.AddMvc();
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

//for swagger to use jwt
builder.Services.AddSwaggerGen(options =>
{
    options.AddSecurityDefinition("oauth2", new OpenApiSecurityScheme
    {
        Description = "Standard Authorization header using the Bearer scheme (\"bearer {token}\")",
        In = ParameterLocation.Header,
        Name = "Authorization",
        Type = SecuritySchemeType.ApiKey
    });
    options.OperationFilter<SecurityRequirementsOperationFilter>();
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.UseCors("AllowAllOrigin");

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();


app.Run();
