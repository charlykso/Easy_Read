using Microsoft.EntityFrameworkCore;

namespace API.Models
{
    public class EasyReaderDBContext: DbContext
    {
        public EasyReaderDBContext(DbContextOptions<EasyReaderDBContext> options):base(options)
        {
            
        }

        protected virtual void onModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Book_User>()
                .HasOne(b => b.Book)
                .WithMany(bu => bu.Book_User)
                .HasForeignKey(bi => bi.BookId);

            modelBuilder.Entity<Book_User>()
                .HasOne(b => b.User)
                .WithMany(bu => bu.Book_User)
                .HasForeignKey(bi => bi.UserId);
        }

        public DbSet<User> Users { get; set; } = null!;
        public DbSet<Book> Books { get; set; } = null!;
        public DbSet<Author> Authors { get; set; } = null!;
        public DbSet<Book_User> Book_Users { get; set; } = null!;
    }
}