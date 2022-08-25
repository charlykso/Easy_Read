import Home from './components/main_pages/Home'
import Users from './components/main_pages/Users'
import Authors from './components/main_pages/Authors'
import Books from './components/main_pages/Books'
import Navbar from './components/main_pages/Navbar'
import Payments from './components/main_pages/Payments'
import Footer from './components/main_pages/Footer'
import Login from './components/auth_pages/Login'
import { Routes, Route } from 'react-router-dom'
import ProtectedRoutes from './components/auth_pages/ProtectedRoutes'


function App() {
  return (
    <div className='App'>
      <Navbar />
      <div className='section '>
        <Routes>
          <Route path='/login' element={<Login />} />
          <Route element={<ProtectedRoutes />}>
            <Route exact path='/' element={<Home />} />
            <Route path='/users' element={<Users />} />
            <Route path='/authors' element={<Authors />} />
            <Route path='/books' element={<Books />} />
            <Route path='/payments' element={<Payments />} />
          </Route>
        </Routes>
      </div>
      <Footer />
    </div>
  )
}

export default App
