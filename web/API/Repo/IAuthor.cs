using API.Models;

namespace API.Repo
{
    public interface IAuthor
    {
        public Task<IEnumerable<Author>> GetAllAuthors();
        public Task<Author> GetAuthor(int Id);
        public void CreateAuthor(Author NewAuthor);
        public void UpdateAuthor(int Id, Author EditAuthor);
        public void DeleteAuthor(int Id);
    }
}