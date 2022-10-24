import React from "react";
import Home from './components/main_pages/Home'
import Users from './components/main_pages/Users'
import Authors from './components/main_pages/Authors'
import Books from './components/main_pages/Books'
import Navbar from './components/main_pages/Navbar'
import Payments from './components/main_pages/Payments'
import Footer from './components/main_pages/Footer'
import Login from './components/auth_pages/Login'
import { Routes, Route, Navigate } from 'react-router-dom'
import CreateUser from './components/main_pages/CreateUser'
import CreateAuthor from './components/main_pages/CreateAuthor'
import ViewAuthor from "./components/main_pages/ViewAuthor";
import ViewUser from './components/main_pages/ViewUser'
import ViewBook from './components/main_pages/ViewBook'
import CreateBook from './components/main_pages/CreateBook'
import { useAuthContext } from './hooks/useAuthContext'

function App() {
  const { user } = useAuthContext()
  return (
    <div className='App'>
      <Navbar />
      <div className='section min-h-screen'>
        <Routes>
          <Route
            path='/login'
            element={!user ? <Login /> : <Navigate to='/' />}
          />
          <Route exact path='/' element={user ? <Home /> : <Login />} />
          <Route path='/users' element={user ? <Users /> : <Login />} />
          <Route path='/authors' element={user ? <Authors /> : <Login />} />
          <Route path='/books' element={user ? <Books /> : <Login />} />
          <Route path='/payments' element={user ? <Payments /> : <Login />} />
          <Route
            path='/author/add'
            element={user ? <CreateAuthor /> : <Login />}
          />
          <Route path='/user/add' element={user ? <CreateUser /> : <Login />} />
          <Route
            path='/Author/UpdateAuthor/:Id'
            element={user ? <ViewAuthor /> : <Login />}
          />
          <Route
            path='/User/UpdateUser/:Id'
            element={user ? <ViewUser /> : <Login />}
          />
          <Route
            path='/Book/UpdateBook/:Id'
            element={user ? <ViewBook /> : <Login />}
          />
          <Route path='/book/add' element={user ? <CreateBook /> : <Login />} />
        </Routes>
      </div>
      <Footer />
    </div>
  )
}

export default App
