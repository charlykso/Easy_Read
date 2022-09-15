import { Link } from "react-router-dom";
const Logout = () => {
    const handleLogout = () => {
        localStorage.clear();
        localStorage.remove("token")
        window.location.href = '/login';
    }
    return (
      <Link
        to='/singUp'
        className='inline-block w-full px-4 py-2 text-center text-gray-800 bg-white rounded-md shadow hover:bg-gray-300' 
        onClick={handleLogout}
      >
        Sign out
      </Link>
    )
}
 
export default Logout;