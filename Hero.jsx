import React from 'react';

const HeroSection = () => {
  return (
    <div className="bg-gradient-to-r from-green-500 to-yellow-500 py-20 px-8 text-black flex h-screen items-center justify-between">
      <div className="text-left max-w-md">
        <h1 className="text-4xl font-bold mb-4">
          Smart Lending, <br /><br /> Trusted Communities, <br /><br /> Empowered Growth.
        </h1>
        <div className="flex space-x-4 mb-8">
          <button className="mt-[100px] bg-green-700 text-white px-6 py-2 rounded-md hover:bg-green-800">
            Lend
          </button>
          <button className="mt-[100px] bg-yellow-500 text-black px-6 py-2 rounded-md hover:bg-yellow-600">
            Borrow
          </button>
        </div>
      </div>
      <div>
        <img src="/Screenshot_2024-11-08_194259-removebg-preview.png" alt="" className="h-64 w-auto" />
      </div>
    </div>
  );
};

export default HeroSection;