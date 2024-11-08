import React from 'react';

const Header = () => {
  return (
    <header className="bg-white text-black py-4 px-6 flex justify-between items-center">
        <div className="flex items-center">
        <img src='/Screenshot_2024-11-08_130636-removebg-preview.png' alt="Company Logo" className="mr-2 h-10 w-auto" />
      </div>
      <button className="bg- text-green-700 px-4 py-2 rounded-md hover:bg-green-100">
        Connect Wallet
      </button>
    </header>
  );
};

export default Header;