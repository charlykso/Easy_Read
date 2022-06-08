using API.Models;

namespace API.Repo
{
    public interface IAuthor
    {
        public IEnumerable<Author> GetAllAuthors();
        public Author GetAuthor(int Id);
        public void CreateAuthor(Author NewAuthor);
        public void UpdateAuthor(int Id, Author EditAuthor);
        public void DeleteAuthor(int Id);
    }
}